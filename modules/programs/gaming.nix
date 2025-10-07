{ config, pkgs, ... }:
{
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
  ];
}

