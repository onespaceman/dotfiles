{
  virtualisation.oci-containers.containers.calibre = {
    image = "crocodilestick/calibre-web-automated:latest";
    hostname = "calibre";
    autoStart = true;
    autoRemoveOnStop = false;
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
    };
    networks = ["pub"];
    ports = ["50005:8083/tcp"];
    volumes = [
      "/docker/calibre-web:/config"
      "/mnt/3/book:/calibre-library"
    ];
    labels = {
      "caddy" = "book.spaceman.one";
      "caddy.import" = "common";
      "caddy.reverse_proxy" = "calibre:8083";
    };
  };
}
