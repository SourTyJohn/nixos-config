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

  imports =
    [
      # |-------------------------------------------------------------------------|
      # |                         <  PACKAGE OVERRIDES  >                         |
      # |-------------------------------------------------------------------------|
      ../../overrides/nix-user-repos.nix


      # |-------------------------------------------------------------------------|
      # |                             <  DESKTOP  >                               |
      # |-------------------------------------------------------------------------|
      ../../modules/desktop/plasma/home.nix


      # |-------------------------------------------------------------------------|
      # |                            <  REQUIRED  >                               |
      # |-------------------------------------------------------------------------|
      ../../modules/programs/zsh.nix
      ../../modules/programs/albert.nix
      ../../modules/programs/brave.nix
      ../../modules/programs/browser.nix
      ../../modules/programs/programming.nix


      # |-------------------------------------------------------------------------|
      # |                            <  PROGRAMS  >                               |
      # |-------------------------------------------------------------------------|
      ../../modules/programs/fastfetch.nix
      ../../modules/programs/gpg.nix
      ../../modules/programs/obs.nix
      ../../modules/programs/telegram.nix
      ../../modules/programs/vlc.nix
#       ../../modules/programs/discord.nix
    ];


  # |-----------------------------------------------------------------------------|
  # |                                <  GENERAL  >                                |
  # |-----------------------------------------------------------------------------|
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
