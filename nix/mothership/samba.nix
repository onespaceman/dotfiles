{config, ...}: {
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
          "hosts allow" = "10.0.0. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "browseable" = "yes";
          "read only" = "yes";
          # "guest ok" = "yes";
          "write list" = "spaceman";
          "create mask" = "0644";
          "force user" = "spaceman";
          "force group" = "users";
        };
        book.path = "/mnt/3/book";
        dl.path = "/mnt/1/dl";
        mov.path = "/mnt/1/mov";
        mus.path = "/mnt/3/mus";
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
