{ config, pkgs, ... }:
{
  networking = {
    hostName = "nixos";
    
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };

    wireless.iwd.enable = true;

    firewall = {
      enable = true;
      extraCommands = ''
        iptables -A FORWARD -s 10.0.0.179 -j ACCEPT
        iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
      '';
    };

    nat = {
      enable = true;
      internalInterfaces = [ "eno1" ];
      externalInterface = "wg0";
      extraCommands = ''
        iptables -t nat -A POSTROUTING -s 10.0.0.179 -o wg0 -j MASQUERADE
      '';
    };

    wg-quick.interfaces.wg0.configFile = "/etc/nixos/files/wireguard/wg0.conf";
  };
}
