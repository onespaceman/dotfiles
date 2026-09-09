{config, ...}: {
  age.secrets.silverbullet.file = ./silverbullet.age;

  virtualisation.oci-containers.containers.silverbullet = {
    image = "ghcr.io/silverbulletmd/silverbullet:v2";
    hostname = "silverbullet";
    autoStart = true;
    user = "1000:100";
    environment = {
      SB_REMEMBER_ME_HOURS = "720";
      TZ = "America/New_York";
    };
    environmentFiles = [config.age.secrets.silverbullet.path];
    networks = ["pub"];
    ports = ["3000:3000/tcp"];
    volumes = ["/home/spaceman/notes:/space"];
    labels = {
      "caddy" = "note.spaceman.one";
      "caddy.reverse_proxy" = "{{upstreams 3000}}";
    };
  };
}
