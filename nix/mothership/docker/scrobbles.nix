{
  virtualisation.oci-containers.containers = {
    koito = {
      image = "gabehf/koito:latest";
      hostname = "koito";
      autoStart = true;
      networks = ["pub"];
      ports = ["4110:4110"];
      volumes = ["/docker/koito:/etc/koito"];
      labels = {
        "caddy" = "scrobble.spaceman.one";
        "caddy.import" = "common";
        "caddy.reverse_proxy" = "{{upstreams 4110}}";
      };
    };
    multi-scrobbler = {
      image = "ghcr.io/foxxmd/multi-scrobbler:latest";
      hostname = "multi-scrobbler";
      autoStart = true;
      environment = {
        TZ = "America/New_York";
        PUID = "1000";
        PGID = "100";
        CACHE_VALKEY = "redis://scrobbler-cache:6379";
      };
      networks = ["pub"];
      ports = ["9078:9078"];
      volumes = ["/docker/multiscrobbler:/config"];
      labels = {
        "caddy" = "scrobbler.spaceman.one";
        "caddy.import" = "common";
        "caddy.reverse_proxy" = "{{upstreams 9078}}";
      };
    };
    scrobbler-cache = {
      image = "valkey/valkey:9-alpine";
      hostname = "scrobbler-cache";
      autoStart = true;
      networks = ["priv"];
      volumes = ["/docker/multiscrobbler/cache:/data"];
      cmd = ["valkey-server" "--save" "30" "1" "--loglevel" "warning"];
    };
  };
}
