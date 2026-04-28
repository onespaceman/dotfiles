{ config, ... }:
{
  age.secrets.cloudflare.file = ../../secrets/cloudflare.age;
  
  virtualisation.oci-containers.containers.cloudflared = {
    image = "cloudflare/cloudflared:latest";
    hostname = "cloudflared";
    autoStart = true;
    networks = [ "pub" ];
    cmd = [
      "tunnel"
      "run"
    ];
    environmentFiles = [ config.age.secrets.cloudflare.path ];
  };
}
