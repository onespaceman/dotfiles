{...}: {
  virtualisation.oci-containers.containers = {
    koito = {
      image = "gabehf/koito:latest";
      hostname = "koito";
      autoStart = true;
      networks = ["pub"];
      ports = ["4110:4110"];
      volumes = ["/docker/koito:/etc/koito"];
    };
    multi-scrobbler = {
      image = "ghcr.io/foxxmd/multi-scrobbler:latest";
      hostname = "multi-scrobbler";
      autoStart = true;
      networks = ["pub"];
      ports = ["9078:9078"];
      volumes = ["/docker/multiscrobbler:/config"];
      environment = {
        TZ = "America/New_York";
        PUID = "1000";
        PGID = "100";
      };
    };
  };
}
