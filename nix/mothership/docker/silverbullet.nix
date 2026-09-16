{
  virtualisation.oci-containers.containers.silverbullet = {
    image = "ghcr.io/silverbulletmd/silverbullet:v2";
    hostname = "silverbullet";
    autoStart = true;
    user = "1000:100";
    networks = ["pub"];
    ports = ["3000:3000/tcp"];
    volumes = ["/home/spaceman/notes:/space"];
    labels = {
      "caddy_0" = "sb.spaceman.one";
      "caddy_0.import" = "common";
      "caddy_0.reverse_proxy" = "silverbullet:3000";
      "caddy_1" = "note.spaceman.one";
      "caddy_1.import" = "common";
      "caddy_1.reverse_proxy" = "silverbullet:3000";
    };
  };
}
