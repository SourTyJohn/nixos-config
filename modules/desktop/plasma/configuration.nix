{ inputs, config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    settings.Theme.CursorTheme = "Yaru";
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # Excluding some KDE applications from the default install
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo-widgets
    ffmpegthumbs
    elisa
    khelpcenter
    krdp
    # xwaylandvideobridge
    plasma-browser-integration
  ];

  # Disabled redundant services
  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    "app-org.kde.kalendarac@autostart".enable = false;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
  ];
}
