{ config, pkgs, ... }:

{
  # Enable Tailscale service
  services.tailscale.enable = true;

  # Optional but recommended: use the newer kernel networking features
  networking.firewall = {
    checkReversePath = "loose";
  };
}
