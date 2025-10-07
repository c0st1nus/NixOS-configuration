{ config, pkgs, ... }:
{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."context.properties" = {
      default.clock.rate = 48000;
      default.clock.allowed-rates = [ 48000 44100 ];
      default.clock.quantum = 1024;
      default.clock.min-quantum = 256;
      default.clock.max-quantum = 2048;
    };
    
    extraConfig.pipewire."context.modules" = [
      {
        name = "libpipewire-module-echo-cancel";
        args = {
          monitor.mode = true;
          source.props = {
            node.name = "source_ec";
            node.description = "Echo-cancelled source";
          };
          aec.args = {
            "webrtc.gain_control" = false;
            "webrtc.analog_gain_control" = false;
            "webrtc.digital_gain_control" = false;
            "webrtc.noise_suppression" = true;
          };
        };
      }
    ];
    
    wireplumber.extraConfig."12-input-taming" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "node.name" = "alsa_input.*"; } ];
          actions.update-props = {
            "node.initial-volume" = 0.5;
            "audio.rate" = 48000;
            "node.latency" = "1024/48000";
            "session.suspend-timeout-seconds" = 0;
          };
        }
        {
          matches = [ { "device.name" = "alsa_card.usb-*"; } ];
          actions.update-props = {
            "api.alsa.period-size" = 1024;
            "api.alsa.headroom" = 512;
          };
        }
      ];
    };
  };
}

