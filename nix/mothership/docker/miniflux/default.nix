{config, ...}: {
  age.secrets.miniflux.file = ./miniflux.age;
  #
  virtualisation.oci-containers.containers = {
    miniflux = {
      image = "miniflux/miniflux:latest";
      hostname = "miniflux";
      autoStart = true;
      dependsOn = ["miniflux-db"];
      environmentFiles = [config.age.secrets.miniflux.path];
      networks = ["priv" "pub"];
      ports = ["51111:8080/tcp"];
      labels = {
        "caddy" = "feed.spaceman.one";
        "caddy.reverse_proxy" = "{{upstreams 8080}}";
      };
    };
    miniflux-db = {
      image = "postgres:18";
      hostname = "miniflux-db";
      autoStart = true;
      environmentFiles = [config.age.secrets.miniflux.path];
      networks = ["priv"];
      volumes = ["/docker/miniflux:/var/lib/postgresql"];
    };
  };
}
