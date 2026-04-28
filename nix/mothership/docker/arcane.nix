{config, ...}: {
  age.secrets.arcane.file = ../../secrets/arcane.age;

  virtualisation.oci-containers.containers.arcane = {
    image = "ghcr.io/getarcaneapp/arcane:latest";
    hostname = "arcane";
    autoStart = true;
    networks = ["pub"];
    ports = ["3552:3552"];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/docker/arcane:/app/data"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
      APP_URL = "http://10.0.0.4:3552";
    };
    environmentFiles = [config.age.secrets.arcane.path];
  };
}
