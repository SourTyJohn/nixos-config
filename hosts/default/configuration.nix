{ inputs, config, pkgs, userConfig, ... }:

let 
  wallpaper = ../../misc/wallpaper.jpg;
in
{
  # |-----------------------------------------------------------------------------|
  # |                           <  PACKAGE OVERRIDES  >                           |
  # |-----------------------------------------------------------------------------|
  nixpkgs.overlays = [
    (
      f: p: { zapret-data = 
      p.callPackage ../../packages/nixos/zapret-data.nix { }; 
    })
    (
      f: p: { elegant-grub-theme = 
      p.callPackage ../../packages/nixos/elegant-grub-theme.nix { }; 
    })
  ];

  imports =
  [
    # |---------------------------------------------------------------------------|
    # |                              <  HARDWARE  >                               |
    # |---------------------------------------------------------------------------|
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-laptop
    ../../modules/configuration/hardware.nix


    # |---------------------------------------------------------------------------|
    # |                              <  DESKTOP  >                                |
    # |---------------------------------------------------------------------------|
    ../../modules/desktop/plasma/configuration.nix


    # |---------------------------------------------------------------------------|
    # |                               <  SYSTEM  >                                |
    # |---------------------------------------------------------------------------|
    ../../modules/configuration/bootloader.nix
    ../../modules/configuration/network.nix


    # |---------------------------------------------------------------------------|
    # |                        <  PROGRAMS + SERVICES  >                          |
    # |---------------------------------------------------------------------------|
    ../../modules/configuration/steam.nix
    ../../modules/configuration/cursor.nix
    ../../modules/configuration/libreoffice.nix

    ../../modules/services/zapret.nix
    ../../modules/services/trillium.nix
    ../../modules/services/postgres.nix
    ../../modules/services/drive-monitoring.nix
  ];


  # |-----------------------------------------------------------------------------|
  # |                             <  NIX SETTINGS  >                              |
  # |-----------------------------------------------------------------------------|
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };
  nixpkgs.config.allowUnfree = true;


  # |-----------------------------------------------------------------------------|
  # |                      <  HOME MANAGER + USER CONFIG  >                       |
  # |-----------------------------------------------------------------------------|
  users.users = userConfig.users;  # userConfig defined in flake.nix
  security.sudo.wheelNeedsPassword = false;  # disable password input for sudo command

  # enable zsh shell globally
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];  # zsh shell from ./home.nix
  

  # |-----------------------------------------------------------------------------|
  # |                       <  INSTALLED SYSTEM PACKAGES  >                       |
  # |-----------------------------------------------------------------------------|
  environment.systemPackages = with pkgs; [
    # Theme packages
    yaru-theme
    # (writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
    #   [General]
    #   background=${wallpaper};
    #   type=image
    # '')
    # Theme packages: additional
    gcc
    glib
    gnumake
    killall
    mesa
    # my apps
    wget
    vlc # Cross-platform media player and streaming server
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland
    openblas
    # utils
    p7zip # archive manager
  ];


  # |-----------------------------------------------------------------------------|
  # |                             <  LOCALIZATION  >                              |
  # |-----------------------------------------------------------------------------|
  time.timeZone = "Europe/Saratov";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };


  # |-----------------------------------------------------------------------------|
  # |                                <  DEVICES >                                 |
  # |-----------------------------------------------------------------------------|
  services.printing.enable = false;
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # |-----------------------------------------------------------------------------|
  # |                                <  GENERAL >                                 |
  # |-----------------------------------------------------------------------------|

  # Enable Wayland support in Chromium and Electron based applications
  # Remove decorations for QT apps
  # Set cursor size
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XCURSOR_SIZE = "24";
  };

  # keyboard layouts: US + RU
  services.xserver = {
    xkb.layout = "us,ru";
    xkb.options = "grp:win_space_toggle";
  };

  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

  system.stateVersion = "25.05";
}
