{ inputs, config, pkgs, ... }:

let 
  silent_boot = false;
  skip_generation_selection = false;
in
{
  boot = {
    # loader.grub.devices = [ "/dev/nvme0n1" ];
    
    loader.grub = {
      efiSupport = true;
      theme = pkgs.elegant-grub-theme.override {
        theme = "wave";
        type = "float";
        side = "left";
        color = "dark";
        resolution = "1080p";
        logo = "Nixos";
      };
    };

    # eufi
    loader.efi.canTouchEfiVariables = true;

    # LINUX KERNEL VERSION
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["splash"];

    # 
    consoleLogLevel = if silent_boot then 0 else 4;
    initrd.verbose = if silent_boot then false else true;
    loader.timeout = if skip_generation_selection then 0 else 5;
    #

    loader.systemd-boot.enable = true;
    plymouth.enable = true;

    # v4l (virtual camera) module settings
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };
}
