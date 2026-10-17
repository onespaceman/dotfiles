{
  virtualisation.oci-containers.containers.silverbullet = {
    image = "ghcr.io/silverbulletmd/silverbullet:v2";
    hostname = "silverbullet";
    autoStart = true;
    autoRemoveOnStop = false;
    user = "1000:100";
    networks = ["pub"];
    ports = ["3000:3000/tcp"];
    volumes = ["/home/spaceman/notes:/space"];
    labels = {
      "caddy_0" = "sb.{$URL}";
      "caddy_0.import" = "common";
      "caddy_0.reverse_proxy" = "silverbullet:3000";
      "caddy_1" = "note.{$URL}";
      "caddy_1.import" = "common";
      "caddy_1.reverse_proxy" = "silverbullet:3000";
    };
  };
}
