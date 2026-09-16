{
  virtualisation.oci-containers.containers.rt = {
    image = "ghcr.io/crazy-max/rtorrent-rutorrent:latest";
    hostname = "rt";
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
    };
    networks = ["pub"];
    ports = [
      "6881:6881/udp" # RT DHT
      "50000:50000/tcp" # RT Incoming
      "50001:8080/tcp" # RUT Webui
      "8000:8000/tcp" # XMLRPC
      "9000:9000/tcp" # WEBDAV
    ];
    volumes = [
      "/docker/rtorrent:/data"
      "/docker/rtorrent/passwd:/passwd"
      "/mnt/1/dl/downloads:/downloads"
      "/mnt/1/dl/watch:/data/rtorrent/watch"
    ];
    labels = {
      "caddy" = "rt.spaceman.one";
      "caddy.import" = "common";
      "caddy.reverse_proxy" = "rt:8080";
    };
  };
}
