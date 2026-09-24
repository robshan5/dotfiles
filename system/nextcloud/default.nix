{ pkgs, vars, ... }:

{
  services.nextcloud = {
    enable   = true;
    hostName = "nextcloud.${vars.domain}";
    https    = true;
    package  = pkgs.nextcloud32; # pin major version; bump one major at a time

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
    # extraApps = with config.services.nextcloud.package.packages.apps; [
    #   calendar
    #   contacts
    #   notes
    #   tasks
    # ];
  };
}
