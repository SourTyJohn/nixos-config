{ config, pkgs, ... }:

{
  config.services.smartd.enable = true;
  config.services.prometheus.exporters.smartctl.enable = true;
}
