{
  virtualisation.oci-containers.containers.audiobookshelf = {
    image = "ghcr.io/advplyr/audiobookshelf:latest";
    hostname = "audiobookshelf";
    autoStart = true;
    autoRemoveOnStop = false;
    user = "1000:100";
    environment = {
      TZ = "America/New_York";
    };
    networks = ["pub"];
    ports = ["50005:80"];
    volumes = [
      "/docker/audiobookshelf/config:/config"
      "/docker/audiobookshelf/metadata:/metadata"
      "/mnt/3/book:/audiobooks"
    ];
    labels = {
      "caddy" = "book.{$URL}";
      "caddy.import" = "common";
      "caddy.reverse_proxy" = "audiobookshelf:80";
    };
  };
}
