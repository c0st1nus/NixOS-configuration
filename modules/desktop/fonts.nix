{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    ubuntu_font_family
    jetbrains-mono
    liberation_ttf
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.fira-code
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}

