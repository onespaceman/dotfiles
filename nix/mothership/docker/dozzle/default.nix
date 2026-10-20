{config, ...}: {
  age.secrets.dozzle.file = ./dozzle.age;

  virtualisation.oci-containers.containers.dozzle = {
    image = "amir20/dozzle:latest";
    hostname = "dozzle";
    autoStart = true;
    autoRemoveOnStop = false;
    networks = ["pub"];
    ports = ["8080:8080"];
    environment = {
      DOZZLE_NO_ANALYTICS = "true";
      DOZZLE_ENABLE_ACTIONS = "true";
      DOZZLE_ENABLE_SHELL = "true";
      DOZZLE_AUTO_UPDATE_TIME = "10:00";
    };
    environmentFiles = [config.age.secrets.dozzle.path];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/docker/dozzle:/data"
    ];
    labels = {
      "caddy" = "d.{$URL}";
      "caddy.import" = "common";
      "caddy.reverse_proxy" = "dozzle:8080";
    };
  };
}
