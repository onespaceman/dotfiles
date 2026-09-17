{
  virtualisation.oci-containers.containers.dockhand = {
    image = "fnsys/dockhand:latest";
    hostname = "dockhand";
    autoStart = true;
    autoRemoveOnStop = false;
    extraOptions = ["--group-add=131"];
    networks = ["pub"];
    ports = ["8080:3000"];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/docker/dockhand:/app/data"
    ];
    labels = {
      "caddy" = "d.spaceman.one";
      "caddy.import" = "common";
      "caddy.reverse_proxy" = "dockhand:3000";
    };
  };
}
