{ pkgs }:

with pkgs; [
  # General packages for development and system management
  alacritty
  #aspell
  #aspellDicts.en
  bat
  coreutils
  killall
  openssh
  wget
  zip

  # Encryption and security tools
  gnupg

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  emacs-all-the-icons-fonts
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
  ripgrep
  tree
  tmux
  unrar
  unzip
]
