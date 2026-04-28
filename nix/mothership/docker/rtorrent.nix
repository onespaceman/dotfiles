{ ... }:
{
  virtualisation.oci-containers.containers.rtorrent = {
    image = "ghcr.io/crazy-max/rtorrent-rutorrent:latest";
    hostname = "rtorrent";
    autoStart = true;
    networks = [ "pub" ];
    ports = [
      "6881:6881/udp" # RT DHT
      "55000:50000/tcp" # RT Incoming
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
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
    };
  };
}
