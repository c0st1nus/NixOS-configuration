{ config, pkgs, ... }:
{
  services.xserver = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.gnome = {
    gnome-keyring.enable = true;
    core-apps.enable = true;
    games.enable = false;
    localsearch.enable = false;
    tinysparql.enable = false;
  };

  services.packagekit.enable = false;
  services.printing.enable = true;

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  environment.systemPackages = with pkgs; [
    dconf-editor
    gnome-tweaks
  ];
}

