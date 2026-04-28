{ config, ... }:
{
  age.secrets.miniflux.file = ../../secrets/miniflux.age;

  virtualisation.oci-containers.containers = {
    miniflux = {
      image = "miniflux/miniflux:latest";
      hostname = "miniflux";
      autoStart = true;
      dependsOn = [ "miniflux-db" ];
      networks = [
        "priv"
        "pub"
      ];
      ports = [ "51111:8080/tcp" ];
      environmentFiles = [ config.age.secrets.miniflux.path ];
    };
    miniflux-db = {
      image = "postgres:18";
      hostname = "miniflux-db";
      autoStart = true;
      networks = [ "priv" ];
      volumes = [ "/docker/miniflux:/var/lib/postgresql" ];
      environmentFiles = [ config.age.secrets.miniflux.path ];
    };
  };
}
