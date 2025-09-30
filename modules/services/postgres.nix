{ config, pkgs, ... }:

{
  config.environment.systemPackages = with pkgs; [ pgadmin4 ];
  
  config.services.postgresql = {
    enable = true;
    ensureDatabases = [ "test" ];
  
    identMap = ''
      superuser_map      nix      postgres
    '';
  };

  environment.sessionVariables = {
    PGDATA = "/var/lib/postgresql/16/";
  };
}
