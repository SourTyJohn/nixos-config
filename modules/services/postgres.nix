{ config, pkgs, ... }:

{
  config.environment = {
    systemPackages = with pkgs; [ pgadmin4 ];
    sessionVariables = {
      PGDATA = "/var/lib/postgresql/16/";
    };
  };
  
  config.services.postgresql = {
    enable = true;
    ensureDatabases = [ "test" ];
  
    identMap = ''
      superuser_map      nix      postgres
    '';
  };
}
