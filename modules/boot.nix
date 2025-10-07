{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    kernelPackages = pkgs.linuxPackages_6_6;
    
    kernelParams = [
      "amd_pstate=guided"
      "transparent_hugepage=madvise"
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
      "radeon.si_support=0"
      "radeon.cik_support=0"
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=0"
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"
      "nvidia.NVreg_UsePageAttributeTable=1"
      "nvidia.NVreg_EnablePCIeGen3=1"
    ];

    initrd.kernelModules = [ "amdgpu" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    blacklistedKernelModules = [ "nouveau" ];
    crashDump.enable = true;

    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.core.rmem_default" = 262144;
      "net.core.wmem_default" = 262144;
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 15;
      "vm.dirty_background_ratio" = 5;
      "fs.inotify.max_user_watches" = 524288;
      "kernel.sysrq" = 1;
      "kernel.hung_task_timeout_secs" = 120;
    };
  };
}

