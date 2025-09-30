{ config, pkgs, ... }:

{
  config.environment.systemPackages = with pkgs; [ code-cursor ];
}
