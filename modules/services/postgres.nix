{ config, pkgs, userConfig, ... }:

let 
  pgversion = "17";
in
{
  config.environment = {
    systemPackages = with pkgs; [ pgadmin4 ];
    sessionVariables.PGDATA = "/var/lib/postgresql/${pgversion}";
  };
  
  config.services.postgresql = {
    enable = true;
    # dataDir = "${userConfig.home-manager-home-dir}/pgdata";
    package = pkgs."postgresql_${pgversion}";

    ensureDatabases = [ "postgres" ];
    ensureUsers = [
      {
        name = "postgres";
        ensureDBOwnership = true;
      }
    ];

    identMap = ''
      superuser_map      nix      postgres
    '';
  };
}
