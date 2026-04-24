{
  config,
  lib,
  pkgs,
  ...
}:
{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = config.networking.hostName;
          "netbios name" = config.networking.hostName;
          "security" = "user";
          #"use sendfile" = "yes";
          #"max protocol" = "smb2";
          # note: localhost is the ipv6 localhost ::1
          "hosts allow" = "10.0.0. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        # "public" = {
        #   "path" = "/mnt/Shares/Public";
        #   "browseable" = "yes";
        #   "read only" = "no";
        #   "guest ok" = "yes";
        #   "create mask" = "0644";
        #   "directory mask" = "0755";
        #   "force user" = "spaceman";
        #   "force group" = "users";
        # };
        # "private" = {
        #   "path" = "/mnt/Shares/Private";
        #   "browseable" = "yes";
        #   "read only" = "no";
        #   "guest ok" = "no";
        #   "create mask" = "0644";
        #   "directory mask" = "0755";
        #   "force user" = "spaceman";
        #   "force group" = "users";
        # };
      };
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    avahi = {
      publish.enable = true;
      publish.userServices = true;
      nssmdns4 = true;
      enable = true;
      openFirewall = true;
    };
  };
}
