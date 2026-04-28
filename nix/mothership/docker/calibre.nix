{ ... }:
{
  virtualisation.oci-containers.containers.calibre-web = {
    image = "crocodilestick/calibre-web-automated:latest";
    hostname = "calibre";
    autoStart = true;
    networks = [ "pub" ];
    ports = [ "50005:8083/tcp" ];
    volumes = [
      "/docker/calibre-web:/config"
      "/mnt/3/book:/calibre-web"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
    };
  };
}
