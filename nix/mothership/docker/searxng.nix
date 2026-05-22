{...}: {
  virtualisation.oci-containers.containers = {
    searxng = {
      image = "searxng/searxng:latest";
      hostname = "searxng";
      autoStart = true;
      networks = ["pub" "priv"];
      ports = ["45000:8080"];
      volumes = [
        "/docker/searxng:/etc/searxng"
        "/docker/searxng/cache:/var/cache/searxng"
      ];
      environment = {
        SEARXNG_VALKEY_URL = "valkey://searxng-cache:6379/0";
      };
    };
    searxng-cache = {
      image = "valkey/valkey:9-alpine";
      hostname = "searxng-cache";
      autoStart = true;
      networks = ["priv"];
      volumes = ["valkey-data:/data"];
      cmd = ["valkey-server" "--save" "30" "1" "--loglevel" "warning"];
    };
  };
}
