{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "media.ffmpeg.vaapi.enabled" = true;
      "media.rdd-ffmpeg.enabled" = true;
      "gfx.webrender.all" = true;
      "layers.acceleration.force-enabled" = true;
      "widget.use-xdg-desktop-portal" = true;
    };
  };
}

