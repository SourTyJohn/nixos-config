{ config, pkgs, ... }:

{
  config.services.postgresql = {
    enable = true;
    ensureDatabases = [ "test" ];
  
    identMap = ''
      superuser_map      nix      postgres
    '';
  };
}
