{ config, pkgs, ... }:

{
  # Enable Tailscale service
  services.tailscale.enable = true;

  # Optional but recommended: use the newer kernel networking features
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
  };

  # Allow Tailscale traffic
  networking.firewall.allowedUDPPorts = [ 41641 ];

  # (Optional) enable MagicDNS support
  services.tailscale.useRoutingFeatures = "client";
}
