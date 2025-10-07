{ config, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
  };

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vscode.fhs
    git
    gcc
    pkg-config
    openssl
    nodejs
    python3Full
    rustfmt
    rust-analyzer
    clippy
    rustup
    docker-compose
    sqlitebrowser
    posting
    meson
    ninja
    glib
  ];

  environment.extraOutputsToInstall = [ "dev" ];
  environment.pathsToLink = [ "/lib/pkgconfig" "/share/pkgconfig" "/include" ];
  
  environment.sessionVariables = {
    PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig:/run/current-system/sw/share/pkgconfig";
  };
}

