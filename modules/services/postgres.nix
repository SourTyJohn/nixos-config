{ config, pkgs, ... }:

{
  config.packages = with pkgs; [ pgadmin ];
  
  config.services.postgresql = {
    enable = true;
    ensureDatabases = [ "test" ];
  
    identMap = ''
      superuser_map      nix      postgres
    '';
  };
}
