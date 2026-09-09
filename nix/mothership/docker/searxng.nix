{
  virtualisation.oci-containers.containers = {
    searxng = {
      image = "searxng/searxng:latest";
      hostname = "searxng";
      autoStart = true;
      environment = {
        SEARXNG_VALKEY_URL = "valkey://searxng-cache:6379/0";
      };
      networks = ["pub" "priv"];
      ports = ["45000:8080"];
      volumes = [
        "/docker/searxng:/etc/searxng:Z"
        "/docker/searxng/cache:/var/cache/searxng"
      ];
      labels = {
        "caddy" = "s.spaceman.one";
        "caddy.import" = "common";
        "caddy.reverse_proxy" = "{{upstreams 8080}}";
      };
    };
    searxng-cache = {
      image = "valkey/valkey:9-alpine";
      hostname = "searxng-cache";
      autoStart = true;
      networks = ["priv"];
      volumes = ["/docker/searxng/valkey:/data"];
      cmd = ["valkey-server" "--save" "30" "1" "--loglevel" "warning"];
    };
  };
}
