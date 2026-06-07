{ pkgs, config,  ... }:

{
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
}
