{ config, pkgs, ... }:

{
  home = {
    username = "nix";
    homeDirectory = "/home/nix";
    stateVersion = "25.05";

    packages = with pkgs; [
      dig
      fd
      jq
      lshw
      # theme
      (catppuccin-kde.override {
        flavour = [ "macchiato" ];
        accents = [ "lavender" ];
      })
      kde-rounded-corners
      kdePackages.kcalc
      kdePackages.krohnkite
      kdotool
      tela-circle-icon-theme
    ];
  };

  # |-----------------------------------------------------------------------------|
  # |                           <  PACKAGE OVERRIDES  >                            |
  # |-----------------------------------------------------------------------------|
  nixpkgs.overlays = [
    (
      f: p: { zapret-data = 
      p.callPackage ../../packages/home/nix-user-repos.nix { }; 
    })
    (
      f: p: { betterfox = 
      p.callPackage ../../packages/home/firefox-betterfox.nix { }; 
    })
    (
      f: p: { minifox = 
      p.callPackage ../../packages/home/firefox-minifox.nix { }; 
    })
  ];

  imports =
    [
      # |-------------------------------------------------------------------------|
      # |                             <  DESKTOP  >                               |
      # |-------------------------------------------------------------------------|
      ../../modules/desktop/plasma/home.nix


      # |-------------------------------------------------------------------------|
      # |                            <  REQUIRED  >                               |
      # |-------------------------------------------------------------------------|
      ../../modules/home-programs/zsh.nix
      ../../modules/home-programs/albert.nix
      ../../modules/home-programs/brave.nix
      ../../modules/home-programs/browser.nix
      ../../modules/home-programs/programming.nix


      # |-------------------------------------------------------------------------|
      # |                            <  PROGRAMS  >                               |
      # |-------------------------------------------------------------------------|
      ../../modules/home-programs/fastfetch.nix
      ../../modules/home-programs/gpg.nix
      ../../modules/home-programs/obs.nix
      ../../modules/home-programs/telegram.nix
      ../../modules/home-programs/vlc.nix
      ../../modules/home-programs/discord.nix
      ../../modules/home-programs/kitty.nix
    ];


  # |-----------------------------------------------------------------------------|
  # |                                <  GENERAL  >                                |
  # |-----------------------------------------------------------------------------|
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
