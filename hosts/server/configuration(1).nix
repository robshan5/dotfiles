# /etc/nixos/configuration.nix
# Home server: Nextcloud + Jellyfin + Headscale + Unbound DNS
# Domain: robshan.space (local network only)
#
# SETUP CHECKLIST:
#   1. Replace "yourhostname" with your actual hostname
#   2. Replace "your-timezone" with your timezone (e.g. "Europe/London")
#   3. Replace "your-username" with your Linux user
#   4. Replace "192.168.1.x" with this server's actual local IP (check with: ip a)
#   5. Point your router's DHCP "DNS server" setting to this server's local IP
#      — that's it, no per-host DNS entries needed on the router
#   6. Generate a self-signed wildcard cert (see TLS section below)
#   7. sudo nixos-rebuild switch
#   8. Set Nextcloud admin password file (see Nextcloud section)

{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];


  # ────────────────────────────────────────────────
  # FIREWALL
  # ────────────────────────────────────────────────
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22    # SSH
      53    # DNS (Unbound)
      80    # HTTP  → nginx (redirects to HTTPS)
      443   # HTTPS → nginx
      41641 # Headscale/Tailscale DERP (TCP)
    ];
    allowedUDPPorts = [
      53    # DNS (Unbound)
      41641 # Headscale/Tailscale DERP (UDP)
    ];
  };

  # ────────────────────────────────────────────────
  # TLS — self-signed wildcard cert for local use
  #
  # Run this once on the server to generate the cert:
  #
  #   sudo openssl req -x509 -newkey rsa:4096 -days 3650 -nodes \
  #     -keyout /etc/ssl/robshan.space.key \
  #     -out    /etc/ssl/robshan.space.crt \
  #     -subj "/CN=*.robshan.space" \
  #     -addext "subjectAltName=DNS:robshan.space,DNS:*.robshan.space"
  #
  # Then on each device (phone, laptop, etc.) trust the .crt file:
  #   - Linux: copy to /usr/local/share/ca-certificates/ then update-ca-certificates
  #   - macOS: Keychain Access → import → set "Always Trust"
  #   - Android/iOS: Settings → Security → Install certificate
  #   - Windows: certmgr → Trusted Root Certification Authorities → import
  # ────────────────────────────────────────────────

  # ────────────────────────────────────────────────
  # UNBOUND — local authoritative + recursive DNS
  #
  # What this does:
  #   • Authoritatively answers *.robshan.space → your server's LAN IP
  #   • Forwards everything else to Cloudflare/Google over DNS-over-TLS
  #   • Listens on all interfaces so LAN devices can use it
  #
  # Router setup (one-time, instead of per-host entries):
  #   In your router's DHCP settings, set the "DNS server" handed to
  #   clients as this server's static LAN IP (e.g. 192.168.1.x).
  #   Devices will then automatically use Unbound for all DNS.
  #
  # Give this server a static LAN IP — either via router DHCP reservation
  # (recommended) or by setting networking.interfaces below.
  # ────────────────────────────────────────────────
  services.unbound = {
    enable = true;

    settings = {
      server = {
        # Listen on all interfaces so LAN devices can reach it
        interface = [ "0.0.0.0" "::0" ];
        port      = 53;

        # Allow queries from your LAN (adjust subnet if yours differs)
        access-control = [
          "127.0.0.0/8 allow"
          "192.168.0.0/16 allow"
          "10.0.0.0/8 allow"
          "::1/128 allow"
        ];

        # Hardening
        hide-identity = true;
        hide-version  = true;
        harden-glue   = true;
        harden-dnssec-stripped = true;
        use-caps-for-id = true;

        # Cache
        cache-min-ttl = 300;
        cache-max-ttl = 86400;

        # Performance
        num-threads        = 2;
        so-rcvbuf          = "1m";
        prefetch           = true;
        prefetch-key       = true;

        # ── Local zone for robshan.space ──────────
        # Replace 192.168.1.x with your server's actual LAN IP!
        local-zone = [ ''"robshan.space." static'' ];
        local-data = [
          ''"robshan.space.            A 192.168.1.x"''   # <── change IP
          ''"nextcloud.robshan.space.  A 192.168.1.x"''   # <── change IP
          ''"jellyfin.robshan.space.   A 192.168.1.x"''   # <── change IP
          ''"headscale.robshan.space.  A 192.168.1.x"''   # <── change IP
        ];
      };

      # Forward all other queries upstream via DNS-over-TLS
      forward-zone = [
        {
          name              = ".";
          forward-tls-upstream = true;
          forward-addr = [
            "1.1.1.1@853#cloudflare-dns.com"
            "1.0.0.1@853#cloudflare-dns.com"
            "8.8.8.8@853#dns.google"
            "8.8.4.4@853#dns.google"
          ];
        }
      ];
    };
  };

  # Make the server use its own DNS (so it can resolve robshan.space too)
  networking.nameservers = [ "127.0.0.1" "::1" ];

  # ────────────────────────────────────────────────
  # NGINX — reverse proxy
  # ────────────────────────────────────────────────
  services.nginx = {
    enable = true;
    recommendedGzipSettings  = true;
    recommendedOptimisation   = true;
    recommendedProxySettings  = true;
    recommendedTlsSettings    = true;

    virtualHosts = {

      # ── Nextcloud ──────────────────────────────
      # The nextcloud module hooks into this vhost automatically
      "nextcloud.robshan.space" = {
        forceSSL = true;
        sslCertificate    = "/etc/ssl/robshan.space.crt";
        sslCertificateKey = "/etc/ssl/robshan.space.key";
      };

      # ── Jellyfin ───────────────────────────────
      "jellyfin.robshan.space" = {
        forceSSL = true;
        sslCertificate    = "/etc/ssl/robshan.space.crt";
        sslCertificateKey = "/etc/ssl/robshan.space.key";
        locations."/" = {
          proxyPass       = "http://127.0.0.1:8096";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_buffering off;
          '';
        };
      };

      # ── Headscale ──────────────────────────────
      "headscale.robshan.space" = {
        forceSSL = true;
        sslCertificate    = "/etc/ssl/robshan.space.crt";
        sslCertificateKey = "/etc/ssl/robshan.space.key";
        locations."/" = {
          proxyPass       = "http://127.0.0.1:8080";
          proxyWebsockets = true;
        };
        # gRPC endpoint used by headscale CLI / Tailscale clients
        locations."/headscale.v1.HeadscaleService" = {
          proxyPass  = "grpc://127.0.0.1:50443";
          extraConfig = ''
            grpc_set_header Host $host;
          '';
        };
      };

    };
  };

  # ────────────────────────────────────────────────
  # NEXTCLOUD
  # ────────────────────────────────────────────────
  #
  # Before first nixos-rebuild, create the admin password file:
  #   echo -n "yourSecurePassword" | sudo tee /etc/nextcloud-admin-pass
  #   sudo chmod 400 /etc/nextcloud-admin-pass
  #
  services.nextcloud = {
    enable   = true;
    hostName = "nextcloud.robshan.space";
    https    = true;
    package  = pkgs.nextcloud29; # pin major version; bump intentionally

    datadir = "/var/lib/nextcloud"; # change to a bigger disk if needed

    config = {
      adminuser     = "admin";
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype        = "sqlite"; # fine for personal use
                                 # see PostgreSQL section below for better perf
    };

    maxUploadSize = "16G";
    nginx.recommendedHttpHeaders = true;

    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; [
      calendar
      contacts
      notes
      tasks
    ];
  };

  # ────────────────────────────────────────────────
  # JELLYFIN
  # ────────────────────────────────────────────────
  services.jellyfin = {
    enable       = true;
    openFirewall = false; # nginx handles all ingress
    # Uncomment to move data to a bigger drive:
    # dataDir  = "/mnt/media/jellyfin";
    # cacheDir = "/mnt/media/jellyfin-cache";
  };

  # Hardware transcoding (optional — uncomment if your GPU supports VAAPI):
  # hardware.opengl.enable = true;
  # users.users.jellyfin.extraGroups = [ "video" "render" ];

  # ────────────────────────────────────────────────
  # HEADSCALE  (self-hosted Tailscale control plane)
  # ────────────────────────────────────────────────
  #
  # After first nixos-rebuild:
  #   1. Create a user:      headscale users create rob
  #   2. Create an auth key: headscale preauthkeys create --user rob --reusable
  #   3. On each client:     tailscale up --login-server https://headscale.robshan.space \
  #                                       --authkey <key>
  #
  services.headscale = {
    enable  = true;
    address = "127.0.0.1";
    port    = 8080;

    settings = {
      server_url  = "https://headscale.robshan.space";
      ip_prefixes = [ "100.64.0.0/10" "fd7a:115c:a1e0::/48" ];

      dns_config = {
        override_local_dns = true;
        nameservers        = [ "1.1.1.1" "8.8.8.8" ];
        magic_dns          = true;
        base_domain        = "robshan.space";
      };

      # Uses Tailscale's public DERP relays — works out of the box.
      # Host your own DERP later if you want fully self-contained operation.
      derp.urls = [
        "https://controlplane.tailscale.com/derpmap/default"
      ];

      grpc_listen_addr    = "127.0.0.1:50443";
      grpc_allow_insecure = false;
    };
  };

  # ────────────────────────────────────────────────
  # POSTGRESQL (optional — better than SQLite for Nextcloud)
  #
  # Uncomment this block AND update the nextcloud config block above:
  #   config.dbtype = "pgsql";
  #   config.dbname = "nextcloud";
  #   config.dbuser = "nextcloud";
  #   config.dbhost = "/run/postgresql";
  # ────────────────────────────────────────────────
  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "nextcloud" ];
  #   ensureUsers = [{
  #     name = "nextcloud";
  #     ensureDBOwnership = true;
  #   }];
  # };

  # ────────────────────────────────────────────────
  # AUTO-UPGRADES
  # ────────────────────────────────────────────────
  system.autoUpgrade = {
    enable      = true;
    allowReboot = false;
  };

  system.stateVersion = "24.11"; # don't change after first install
}
