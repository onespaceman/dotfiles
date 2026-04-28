{...}: {
  virtualisation.oci-containers.containers.beets = {
    image = "lscr.io/linuxserver/beets:latest";
    hostname = "beets";
    autoStart = true;
    networks = ["pub"];
    volumes = [
      "/mnt/3/mus/:/music"
      "/mnt/1/dl/:/downloads"
      "/docker/beets:/config"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
    };
  };
}
