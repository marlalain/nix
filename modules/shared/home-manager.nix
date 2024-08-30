{ pkgs, lib, ... }:

let
  name = "Marla Albuquerque";
  user = "marla";
  email = "marla@albuque.com";
in {
  nushell = {
    enable = true;
    configFile.source = ./config/config.nu;
  };

  starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [ "$nix_shell" "$direnv" "$status" "$character" ];
      right_format = lib.concatStrings [ "$git_metrics" "$cmd_duration" "$jobs" "$git_branch" "$git_state" "$username" "@" "$hostname" ];
      character = {
        success_symbol = "[;](bold green)";
        error_symbol = "[;](bold red)";
      };
      status = {
        disabled = false;
        format = "[$status]($style) ";
        map_symbol = true;
      };
      hostname = {
        ssh_only = false;
        format = "$hostname";
      };
      username = {
        show_always = true;
        format = "$user";
      };
      cmd_duration = {
        show_notifications = true;
        min_time = 300000;
        min_time_to_notify = 300000;
        format = "[$duration]($style) ";
        style = "bold red";
      };
      jobs = {
        format = "-j $number ";
      };
      git_state = {
        style = "bold bg:yellow fg:black";
      };
      git_metrics = {
        ignore_submodules = true;
        disabled = false;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
      };
      git_branch = {
        format = "[$branch]($style) ";
        style = "bold";
        ignore_branches = [ "main" "master" ];
      };
    };
  };

  zsh = {
    enable = true;
    autocd = false;
    cdpath = [ "~/.local/share/src" ];
    plugins = [ ];
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.local/share/bin:${pkgs.emacs}/bin:$HOME/.config/emacs/bin:$PATH
      export DOOMDIR="/Users/marla/.config/nix/modules/shared/doom"

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Ripgrep alias
      alias search=rg -p --glob '!node_modules/*'  $@

      # Emacs is my editor
      export ALTERNATE_EDITOR="vim"
      export EDITOR="emacsclient -t"
      export VISUAL="emacsclient -c -a emacs"

      e() {
          emacsclient -t "$@"
      }

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  carapace = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = { enable = true; };
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgsign = false;
      pull.rebase = true;
      rebase.autoStash = true;
      github = {
        user = "marlalain";
      };
      core = {
        editor = "vim";
        autocrlf = "input";
      };
    };
  };

  alacritty = {
    enable = true;
    settings = {
      cursor = { style = "Block"; };

      window = {
        dynamic_padding = false;
        # decorations = "None";
        opacity = 0.8;
        blur = true;
        padding = {
          x = 0;
          y = 0;
        };
      };

      font = {
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        size = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
        ];
      };


      colors = {
        primary = {
          background = "0x1f2528";
          foreground = "0xc0c5ce";
        };

        normal = {
          black = "0x1f2528";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xc0c5ce";
        };

        bright = {
          black = "0x65737e";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xd8dee9";
        };
      };
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external")
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external")
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github")
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github")
        ];
      };
    };
  };

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      {
        plugin = power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'gold'
        '';
      }
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        # FIXME Missing `set -g @resurrect-dir`
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
    prefix = "C-a";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''
      # Remove Vim mode delays
      set -g focus-events on

      # Enable full mouse support
      set -g mouse on

      set -g @tmux_power_date_icon ' '
      set -g @tmux_power_time_icon ' '
      set -g @tmux_power_user_icon ' '
      set -g @tmux_power_session_icon ' '
      set -g @tmux_power_show_upload_speed    true
      set -g @tmux_power_show_download_speed  true
      set -g @tmux_power_show_web_reachable   true
      set -g @tmux_power_right_arrow_icon     ' '
      set -g @tmux_power_left_arrow_icon      ' '
      set -g @tmux_power_upload_speed_icon    ' '
      set -g @tmux_power_download_speed_icon  ' '
      set -g @tmux_power_prefix_highlight_pos 'R'set -g @tmux_power_date_icon ' '

      # -----------------------------------------------------------------------------
      # Key bindings
      # -----------------------------------------------------------------------------

      # Unbind default keys
      unbind C-b
      unbind '"'
      unbind %

      # Split panes, vertical or horizontal
      bind-key x split-window -v
      bind-key v split-window -h

      # Move around panes with vim-like bindings (h,j,k,l)
      bind-key -n M-k select-pane -U
      bind-key -n M-h select-pane -L
      bind-key -n M-j select-pane -D
      bind-key -n M-l select-pane -R

      # Smart pane switching with awareness of Vim splits.
      # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
  };

  lazygit = {
    enable = true;
  };

  gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  ripgrep.enable = true;

  ledger = {
    enable = true;
    settings = {
      date-format = "%d-%m-$Y";
      sort = "date";
      strict = true;
    };
  };
}
