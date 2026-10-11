{config, ...}: {
  age.secrets.degoog.file = ./degoog.age;

  virtualisation.oci-containers.containers = {
    degoog = {
      image = "ghcr.io/degoog-org/degoog:latest";
      hostname = "degoog";
      autoStart = true;
      autoRemoveOnStop = false;
      environment = {
        DEGOOG_PUBLIC_INSTANCE = "true";
        DEGOOG_VALKEY_URL = "redis://degoog-cache:6379";
      };
      environmentFiles = [config.age.secrets.degoog.path];
      networks = ["pub" "priv"];
      ports = ["4444:4444"];
      volumes = ["/docker/degoog:/app/data"];
      labels = {
        "caddy" = "s.spaceman.one";
        "caddy.import" = "common";
        "caddy.reverse_proxy" = "degoog:4444";
      };
    };
    degoog-cache = {
      image = "valkey/valkey:8-alpine";
      hostname = "degoog-cache";
      autoStart = true;
      autoRemoveOnStop = false;
      networks = ["priv"];
      user = "1000:100";
      cmd = ["valkey-server" "--save" "" "--appendonly" "no"];
      extraOptions = ["--read-only=true" "--security-opt=no-new-privileges:true"];
    };
    flaresolverr = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      hostname = "flaresolverr";
      autoStart = true;
      autoRemoveOnStop = false;
      environment = {
        TZ = "America/New_York";
      };
      networks = ["priv"];
      user = "1000:100";
      volumes = ["/docker/flaresolverr:/config"];
    };
  };
}
