{ config, pkgs, lib, home-manager, ... }:

let
  user = "marla";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in {
  imports = [ ./dock ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {
    };
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    masApps = { };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix { };
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
        ];

        stateVersion = "23.11";
      };
      programs = { }
                 // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = true;
      entries = [
        { path = "/Applications/Slack.app/"; }
        { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
      ];
    };
  };

  services.yabai = {
    enable = true;
    config = {
      focus_follows_mouse = "autoraise";
      window_opacity = "off";
      active_window_opacity = 0.9;
      normal_window_opacity = 0.8;
      split_ratio = 0.66;
      split_type = "auto";
      layout = "bsp";
      window_shadow = "on";
      external_bar = "on:40:0";
      menubar_opacity = 0.5;
      window_origin_display = "focused";
      window_zoom_persist = "focused";
      window_placement = "second_child";
      window_animation_duration = 0.0;
      window_opacity_duration = 0.0;
      window_gap = 10;
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      mouse_action2 = "resize";
    };

  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
          hyper - h : yabai -m window --focus west
          hyper - j : yabai -m window --focus south
          hyper - k : yabai -m window --focus north
          hyper - l : yabai -m window --focus east
    '';
  };
}

