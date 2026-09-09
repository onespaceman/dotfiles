{
  virtualisation.oci-containers.containers.navidrome = {
    image = "deluan/navidrome:latest";
    hostname = "navidrome";
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    networks = ["pub"];
    ports = ["55666:4533/tcp"];
    volumes = [
      "/docker/navidrome:/data"
      "/mnt/3/mus:/music"
    ];
    labels = {
      "caddy" = "mus.spaceman.one";
      "caddy.reverse_proxy" = "{{upstreams 4533}}";
    };
  };
}
