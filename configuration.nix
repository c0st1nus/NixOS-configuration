{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/hardware/nvidia.nix
    ./modules/hardware/audio.nix
    ./modules/desktop/gnome.nix
    ./modules/desktop/fonts.nix
    ./modules/desktop/xdg-portal.nix
    ./modules/programs/development.nix
    ./modules/programs/gaming.nix
    ./modules/programs/browsers.nix
    ./modules/programs/databases.nix
    ./modules/services.nix
    ./modules/users.nix
  ];

  time.timeZone = "Asia/Qostanay";
  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;
}
