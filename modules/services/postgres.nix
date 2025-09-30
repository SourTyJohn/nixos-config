{ config, pkgs, userConfig, ... }:

{
  config.environment = {
    systemPackages = with pkgs; [ pgadmin4 ];
  };
  
  config.services.postgresql = {
    enable = true;
    # dataDir = "${userConfig.home-manager-home-dir}/pgdata";
    package = pkgs.postgresql_17;

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
