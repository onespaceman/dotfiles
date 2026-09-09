{config, ...}: {
  age.secrets.pocketid.file = ./pocketid.age;

  virtualisation.oci-containers.containers.pocketid = {
    image = "pocketid/pocket-id:v2";
    hostname = "pocketid";
    autoStart = true;
    networks = ["pub"];
    ports = ["1411:1411"];
    environment = {
      APP_URL = "https://auth.spaceman.one";
      SESSION_DURATION = "1440";
      TRUST_PROXY = "true";
    };
    environmentFiles = [config.age.secrets.pocketid.path];
    volumes = [
      "/docker/pocketid:/app/data"
    ];
    labels = {
      "caddy" = "auth.spaceman.one";
      "caddy.reverse_proxy" = "{{upstreams 1411}}";
    };
  };
}
