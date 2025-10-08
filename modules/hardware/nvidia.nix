{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" "nvidia" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      amdvlk
      rocmPackages.clr.icd
      egl-wayland
      libva
      libvdpau-va-gl
      vaapiVdpau
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      amdvlk
      libva
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    prime = {
      sync.enable = false;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:53:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card0", DRIVERS=="amdgpu", TAG+="mutter-device-preferred-primary"
  '';

  services.asusd.enable = true;
  programs.rog-control-center.enable = true;

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    radeontop
    amdgpu_top
  ];

  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
    __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    WLR_RENDER_DRM_DEVICE = "/dev/dri/renderD128";
  };

  environment.sessionVariables = {
    DRI_PRIME = "pci-0000_53_00_0";
  };
}

