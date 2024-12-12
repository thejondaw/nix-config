{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # === SYSTEM === #
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # === USERS === #

  users.defaultUserShell = pkgs.fish;
    programs.fish = {
      enable = true;
      loginShellInit = ''
      starship init fish | source
     '';
  };

  users.users.jondaw = {
    isNormalUser = true;
    description = "Jon Daw";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  home-manager.users.jondaw = import /home/jondaw/NixOS/home-manager/home.nix;

  # === NETWORK === #
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };

  services.openssh.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # === LOCALIZATION === #
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

# === DESKTOP === #

  console = {
    useXkbConfig = true;
  };

  programs.xwayland.enable = true;
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us,ru";
      variant = "";
    #  options = "grp:alt_shift_toggle,terminate:ctrl_alt_bksp";
    };

    excludePackages = [ pkgs.xterm ];
  };

  # Remove default GNOME apps
  environment.gnome.excludePackages = (with pkgs; [
    gnome-connections
    gnome-photos
    gnome-text-editor
    gnome-tour
    gnome-characters
    gnome-contacts
    gnome-maps
    gnome-console
    gnome-terminal
    gnome-logs
    gnome-music

    epiphany
    geary
    seahorse
    yelp
    simple-scan

  ]) ++ (with pkgs.gnome; [

    # cheese
    # eog
    # evince
    # file-roller
    # totem
    # gnome-calculator
    # gnome-calendar
    # gnome-clocks
    # gnome-disk-utility
    # gnome-font-viewer
    # gnome-screenshot
    # gnome-system-monitor
    # gnome-weather
  ]);

  # === MULTIMEDIA === #
  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # === SECURITY === #
  services.fprintd.enable = true;
  security.pam.services = {
    login.fprintAuth = lib.mkForce true;
    gdm = {
      fprintAuth = lib.mkForce true;
      enableGnomeKeyring = true;
    };
    gdm-password.fprintAuth = lib.mkForce true;
  };

  security.polkit.enable = true;
  security.pam.services.vscode.enableGnomeKeyring = true;

  # === FLATPAK === #
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    requires = [ "network-online.target" "systemd-resolved.service" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # === PACKAGES === #
  environment.systemPackages = with pkgs; [

    # System
    flatpak
    fprintd
    home-manager
    polkit

    # User Interface
    gnome-tweaks
    whitesur-gtk-theme
    xfce.thunar

    # Terminal
    alacritty
    ptyxis
    vim
    bat
    dust
    duf
    lsd
    ripgrep
    wget
    git
    fish
    starship
    fastfetch
    cmatrix
    cava
    btop
    nodejs_23
    puppeteer-cli

    # Fonts
    jetbrains-mono

    # Security
    keepassxc

    # Office
    libreoffice
    obsidian

    # Messengers
    slack
    zoom

    # Media
    gimp
    obs-studio

    # Gaming
    steam
    lutris

    # DevOps
    vscode
    podman
  ];

    # === HYPRLAND === #
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
