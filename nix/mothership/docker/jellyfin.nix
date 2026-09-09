{
  virtualisation.oci-containers.containers.jellyfin = {
    image = "lscr.io/linuxserver/jellyfin";
    hostname = "jellyfin";
    autoStart = true;
    devices = ["/dev/dri:/dev/dri"];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
      JELLYFIN_PublishedServerUrl = "http://10.0.0.4:50500";
    };
    networks = ["pub"];
    ports = [
      "50500:8096" # http
      # "50501:8920" # https
      "7359:7359/udp"
      "1900:1900/udp"
    ];
    volumes = [
      "/docker/jellyfin:/config"
      "/mnt/1/mov/tv/:/data/tvshows"
      "/mnt/1/mov/movies/:/data/movies"
    ];
    labels = {
      "caddy" = "jf.spaceman.one";
      "caddy.import" = "common";
      "caddy.reverse_proxy" = "{{upstreams 8096}}";
    };
  };
}
