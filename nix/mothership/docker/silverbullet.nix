{ config, ... }:
{
  age.secrets.silverbullet.file = ../../secrets/silverbullet.age;

  virtualisation.oci-containers.containers.silverbullet = {
    image = "ghcr.io/silverbulletmd/silverbullet:v2";
    hostname = "silverbullet";
    autoStart = true;
    networks = [ "pub" ];
    ports = [ "3000:3000/tcp" ];
    volumes = [ "/home/spaceman/notes:/space" ];
    environment = {
      SB_REMEMBER_ME_HOURS = "720";
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
    };
    environmentFiles = [ config.age.secrets.silverbullet.path ];
  };
}
