{config, ...}: {
  age.secrets.pocketid.file = ./pocketid.age;

  virtualisation.oci-containers.containers.pocketid = {
    image = "pocketid/pocket-id:v2";
    hostname = "pocketid";
    autoStart = true;
    autoRemoveOnStop = false;
    networks = ["pub"];
    ports = ["1411:1411"];
    environment = {
      SESSION_DURATION = "1440";
    };
    environmentFiles = [config.age.secrets.pocketid.path];
    volumes = [
      "/docker/pocketid:/app/data"
    ];
    labels = {
      "caddy" = "auth.{$URL}";
      "caddy.import" = "common";
      "caddy.reverse_proxy" = "pocketid:1411";
    };
  };
}
