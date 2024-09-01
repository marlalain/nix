{ pkgs }:

with pkgs; [
  discordo

  # General packages for development and system management
  alacritty
  bat
  coreutils
  killall
  openssh
  wget
  zip

  # Emacs
  emacs-all-the-icons-fonts
  direnv
  emacsPackages.vterm
  nil

  # Encryption and security tools
  gnupg

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  tree
  tmux
  unrar
  unzip
  plantuml

  devenv
  lnav
]
