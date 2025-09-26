{ inputs, config, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [
      # networkmanager-strongswan
    ];

    firewall.enable = true;
  };

  # # services.strongswan.swanctl.enable = true;
  # services.strongswan = {
  #   enable = true;
  #   connections = {
  #     beget = {
  #       auto = "start";
  #       type = "tunnel";
  #       left = "<server_ip>";
  #       right = "<server_hostname>";
  #       eap_identity = "user";
  #       ike = "aes256-sha1";
  #       esp = "aes256-sha1";
  #     };
  #   };
  # };
}
