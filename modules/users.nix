{ config, pkgs, ... }:
{
  users.users.const = {
    isNormalUser = true;
    description = "Konstantin";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" "video" ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "rust" "docker" "systemd" ];
    };
  };
}

