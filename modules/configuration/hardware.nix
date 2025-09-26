{ lib, ... }:

{
  hardware.graphics.enable = true;  # enable OpenGL
  services.xserver.videoDrivers = [ "nvidia" ];  # Load nvidia driver for Xorg and Wayland
  hardware.nvidia.open = false;  # for old/proprietary drivers. If newer than RTX 20, set to true

  # for laptop with 2 video cards
  # scan with command: sudo lshs -c 
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:02:0";  # integrated gpu
    nvidiaBusId = "PCI:1:0:0";  # 
    # amdBusId
  };

  # launcn system with both gpu active for better performance
  specialisation = {
    gaming-time.configuration = {
      hardware.nvidia = {
        prime.sync.enable = lib.mkForce true;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
      };
    };
  };

  # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  # Enable this if you have graphical corruption issues or application crashes after waking
  # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
  # of just the bare essentials.
  powerManagement.enable = false;

	# Nvidia settings menu accessible via `nvidia-settings`
}
