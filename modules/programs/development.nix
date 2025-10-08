{ config, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
  };

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vscode
    git
    gcc
    pkg-config
    openssl.dev
    nodejs
    python3Full
    rustup
    docker-compose
    sqlitebrowser
    posting
    meson
    ninja
    glib.dev
  ];

  environment.pathsToLink = [ "/lib/pkgconfig" "/share/pkgconfig" "/include" ];
  
  environment.sessionVariables = {
    PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig:/run/current-system/sw/share/pkgconfig";
  };
}

