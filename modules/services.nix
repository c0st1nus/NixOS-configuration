{ config, pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    thermald.enable = true;
    geoclue2.enable = true;
    flatpak.enable = true;
    
    journald.extraConfig = ''
      Storage=persistent
      SystemMaxUse=1G
    '';
    
    logind = {
      lidSwitch = "ignore";
      extraConfig = "HandleLidSwitch=ignore";
    };
  };

  boot.crashDump.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    transmission_4-gtk
    tcpdump
    openjdk
    obsidian
    v4l-utils
    libv4l
    conky
    tree
    p7zip
    mesa-demos
    vulkan-tools
    neofetch
    (btop.override { cudaSupport = true; rocmSupport = true; })
    discord
    telegram-desktop
    alacritty
    mpv
    ffmpeg
    gtk4
    gjs
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    clapper
    xorg.libXtst
    xorg.libXi
    xorg.libX11
    xorg.libXrandr
    libxkbcommon
    glib-networking
    libGL
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    egl-wayland
    libva-utils
    vdpauinfo
  ];
}

