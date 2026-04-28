{...}: {
  virtualisation.oci-containers.containers.jellyfin = {
    image = "lscr.io/linuxserver/jellyfin";
    hostname = "jellyfin";
    autoStart = true;
    networks = ["pub"];
    ports = [
      "50500:8096"
      "50501:8920"
      "7359:7359/udp"
      "1900:1900/udp"
    ];
    volumes = [
      "/docker/jellyfin:/config"
      "/mnt/1/mov/tv/:/data/tvshows"
      "/mnt/1/mov/movies/:/data/movies"
    ];
    devices = ["/dev/dri:/dev/dri"];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
      JELLYFIN_PublishedServerUrl = "http://10.0.0.4:50500";
    };
  };
}
