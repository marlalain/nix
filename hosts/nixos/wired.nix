{
  config,
  inputs,
  pkgs,
  agenix,
  ...
}:

let
  hostname = "wired";
  user = "marla";
  keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOk8iAnIaa1deoc7jw8YACPNVka1ZFJxhnU4G74TmS+p" ];
in
{
  imports = [
    ../../modules/nixos/secrets.nix
    ../../modules/shared
    ../../modules/shared/cachix
    agenix.nixosModules.default
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.grub = {
      enable = true;
      zfsSupport = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      mirroredBoots = [
        {
          devices = [ "nodev" ];
          path = "/boot";
        }
      ];
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 42;
      # };
      # efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "uinput" ];
    blacklistedKernelModules = [
      "nouveau"
      "nvidiafb"
    ];
    extraModprobeConfig = ''
      softdep nvidia post: nvidia-uvm
    '';
  };

  fileSystems = {
    "/" = {
      device = "party/root";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/F2A4-FB86";
      fsType = "vfat";
    };

    "/nix" = {
      device = "party/nix";
      fsType = "zfs";
    };

    "/var" = {
      device = "party/var";
      fsType = "zfs";
      options = [ "noexec" ];
    };

    "/home" = {
      device = "party/home";
      fsType = "zfs";
    };
  };
  swapDevices = [ ];

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = hostname;
    hostId = "deadb33f";
    networkmanager.enable = true;
    hosts = {
      "10.0.0.2" = [ "the.wired" ];
      "10.0.0.42" = [ "mac.studio" ];
    };
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [
        22
        443
      ];
      allowedUDPPorts = [ ];
    };
  };

  nix = {
    nixPath = [ "nixos-config=/home/${user}/.local/share/src/nixos-config:/etc/nixos" ];
    settings = {
      allowed-users = [
        "${user}"
        "@wheel"
      ];
      trusted-users = [
        "${user}"
        "@wheel"
      ];
    };
    package = pkgs.nix; # or pkgs.nixFlakes
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;
    dconf.enable = true;
    zsh.enable = true;
  };

  services = {
    zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };

    nix-serve = {
      enable = true;
      openFirewall = true;
      package = pkgs.nix-serve;
      port = 8080;
    };

    openssh = {
      allowSFTP = false;

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        AlllowUsers = [ "@{user}" ];
        PrintMotd = false;
      };
    };

    tailscale = {
      enable = true;
      authKeyFile = "/home/marla/.keys/tailscale-auth-key";
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    caddy = {
      enable = false;
      configFile = pkgs.writeText "Caddyfile" '''';
    };

    # Better support for general peripherals
    libinput.enable = false;

    displayManager.defaultSession = "none+bspwm";
    xserver = {
      enable = false;
      # videoDrivers = [ "nvidia" ];

      # This helps fix tearing of windows for Nvidia cards
      screenSection = ''
        Option       "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        Option       "AllowIndirectGLXProtocol" "off"
        Option       "TripleBuffer" "on"
      '';

      # LightDM Display Manager
      displayManager.lightdm = {
        enable = false;
        greeters.slick.enable = false;
        background = ../../modules/nixos/config/login-wallpaper.png;
      };

      # Tiling window manager
      windowManager.bspwm = {
        enable = false;
      };

      # Turn Caps Lock into Ctrl
      xkb = {
        options = "ctrl:nocaps";
        layout = "us";
      };
    };

    # Picom, my window compositor with fancy effects
    #
    # Notes on writing exclude rules:
    #
    #   class_g looks up index 1 in WM_CLASS value for an application
    #   class_i looks up index 0
    #
    #   To find the value for a specific application, use `xprop` at the
    #   terminal and then click on a window of the application in question
    #
    picom = {
      enable = true;
      settings = {
        animations = true;
        animation-stiffness = 300.0;
        animation-dampening = 35.0;
        animation-clamping = false;
        animation-mass = 1;
        animation-for-workspace-switch-in = "auto";
        animation-for-workspace-switch-out = "auto";
        animation-for-open-window = "slide-down";
        animation-for-menu-window = "none";
        animation-for-transient-window = "slide-down";
        corner-radius = 12;
        rounded-corners-exclude = [
          "class_i = 'polybar'"
          "class_g = 'i3lock'"
        ];
        round-borders = 3;
        round-borders-exclude = [ ];
        round-borders-rule = [ ];
        shadow = true;
        shadow-radius = 8;
        shadow-opacity = 0.4;
        shadow-offset-x = -8;
        shadow-offset-y = -8;
        fading = false;
        inactive-opacity = 0.8;
        frame-opacity = 0.7;
        inactive-opacity-override = false;
        active-opacity = 1.0;
        focus-exclude = [ ];

        opacity-rule = [
          "100:class_g = 'i3lock'"
          "60:class_g = 'Dunst'"
          "100:class_g = 'Alacritty' && focused"
          "90:class_g = 'Alacritty' && !focused"
        ];

        blur-kern = "3x3box";
        blur = {
          method = "kernel";
          strength = 8;
          background = false;
          background-frame = false;
          background-fixed = false;
          kern = "3x3box";
        };

        shadow-exclude = [ "class_g = 'Dunst'" ];

        blur-background-exclude = [ "class_g = 'Dunst'" ];

        backend = "glx";
        vsync = false;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = false;
        detect-transient = true;
        detect-client-leader = true;
        use-damage = true;
        log-level = "info";

        wintypes = {
          normal = {
            fade = true;
            shadow = false;
          };
          tooltip = {
            fade = true;
            shadow = false;
            opacity = 0.75;
            focus = true;
            full-shadow = false;
          };
          dock = {
            shadow = false;
          };
          dnd = {
            shadow = false;
          };
          popup_menu = {
            opacity = 1.0;
          };
          dropdown_menu = {
            opacity = 1.0;
          };
        };
      };
    };

    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    # Emacs runs as a daemon
    emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
    };
  };

  # When emacs builds from no cache, it exceeds the 90s timeout default
  systemd.user.services.emacs = {
    serviceConfig.TimeoutStartSec = "7min";
  };

  # Video support
  hardware = { };

  # Add docker daemon
  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
  };

  # It's me, it's you, it's everyone
  users.users = {
    ${user} = {
      isNormalUser = true;
      home = "/home/${user}";
      extraGroups = [
        "wheel"
        "docker"
        "driver"
        "wireshark"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = keys;
    };

    root = {
      openssh.authorizedKeys.keys = keys;
    };
  };

  security = {
    auditd.enable = true;
    audit = {
      enable = true;
      rules = [ "-a exit,always -F arch=b64 -S execve" ];
    };

    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "${user}" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    emacs-all-the-icons-fonts
    feather-font # from overlay
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-emoji
  ];

  environment = {
    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      agenix.packages."${pkgs.system}".default # "x86_64-linux"
      gitAndTools.gitFull
      inetutils
      vim
      wget
      dislocker
      doas-sudo-shim
    ];
  };

  system.stateVersion = "21.05"; # Don't change this
}
