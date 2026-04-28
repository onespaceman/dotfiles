{ config, ... }:
{
  age.secrets.koito.file = ../../secrets/koito.age;

  virtualisation.oci-containers.containers = {
    koito = {
      image = "gabehf/koito:latest";
      hostname = "koito";
      autoStart = true;
      dependsOn = [ "koito-db" ];
      networks = [
        "priv"
        "pub"
      ];
      ports = [ "4110:4110" ];
      volumes = [ "/docker/koito:/etc/koito" ];
      environmentFiles = [ config.age.secrets.koito.path ];
    };
    koito-db = {
      image = "postgres:18";
      hostname = "koito-db";
      autoStart = true;
      ports = [ "5432:5432" ];
      networks = [ "priv" ];
      volumes = [ "/docker/koito/db:/var/lib/postgresql" ];
      environmentFiles = [ config.age.secrets.koito.path ];
    };
    multi-scrobbler = {
      image = "ghcr.io/foxxmd/multi-scrobbler:latest";
      hostname = "multi-scrobbler";
      autoStart = true;
      networks = [ "pub" ];
      ports = [ "9078:9078" ];
      volumes = [ "/docker/multiscrobbler:/config" ];
      environment = {
        TZ = "America/New_York";
        PUID = "1000";
        PGID = "100";
      };
    };
  };
}
