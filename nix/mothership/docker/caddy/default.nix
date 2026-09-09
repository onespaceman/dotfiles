{
  config,
  pkgs,
  ...
  # }: let
  #   # Pull base caddy image
  #   caddyBase = pkgs.dockerTools.pullImage {
  #     imageName = "caddy";
  #     imageDigest = "sha256:df7f1c2fb114453b951de51a98efc010db1655a92c2e86be6706714e2417a78d";
  #     finalImageTag = "2";
  #     hash = "sha256-0uWUw2BoxCMNEP0xCSzaE2k7TiQkT0CrBN5YT2G2prE=";
  #   };
  #   # Build caddy binary with plugins
  #   caddyWithPlugins = pkgs.caddy.withPlugins {
  #     plugins = [
  #       "github.com/lucaslorentz/caddy-docker-proxy/@v2.13.1"
  #       "github.com/mholt/caddy-dynamicdns@v0.0.0-20260805195708-67d107a42c02"
  #       "github.com/hslatman/caddy-crowdsec-bouncer/http@main"
  #       "github.com/hslatman/caddy-crowdsec-bouncer/appsec@main"
  #       "github.com/porech/caddy-maxmind-geolocation@v1.0.1"
  #       "github.com/greenpau/caddy-security@v1.1.64"
  #     ];
  #     hash = "sha256-d2fIlqpHXooyKyN0JN8xgHek+IaYQJHY+kgaMr7kOhU=";
  #   };
  #   # Build caddy image
  #   caddy = pkgs.dockerTools.buildImage {
  #     name = "caddy";
  #     tag = "latest";
  #     fromImage = caddyBase;
  #     fromImageName = "caddy";
  #     fromImageTag = "2";
  #     copyToRoot = "${caddyWithPlugins}/bin";
  #     extraCommands = ''
  #       mkdir -p ./usr/bin
  #       mv ./caimddy ./usr/bin/
  #     '';
  #     config = {
  #       Workdir = "/srv";
  #       Cmd = ["caddy" "run" "--config" "/etc/caddy/Caddyfile" "--adapter" "caddyfile"];
  #     };
  #   };
  # in {
}: {
  networking.firewall.allowedTCPPorts = [80 443];
  age.secrets.caddy.file = ./caddy.age;

  virtualisation.oci-containers.containers.caddy = {
    # image = "caddy:latest";
    # imageFile = caddy;
    image = "ghcr.io/serfriz/caddy-cloudflare-ddns-crowdsec-geoip-security-dockerproxy:latest";
    hostname = "caddy";
    autoStart = true;
    environment = {
      CADDY_INGRESS_NETWORKS = "pub";
      # CADDY_DOCKER_CADDYFILE_PATH = "/base.caddy";
    };
    environmentFiles = [config.age.secrets.caddy.path];
    networks = ["pub"];
    ports = ["80:80" "443:443"];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/docker/caddy:/data"
      # "/docker/caddy/base.caddy:/base.caddy"
    ];
    labels = {
      "caddy_0.dynamic_dns.provider" = "cloudflare {env.CLOUDFLARE_TOKEN}";
      "caddy_0.dynamic_dns.domains.spaceman\\.one" = "*";
      "caddy_0.dynamic_dns.versions" = "ipv6";
    };
  };
}
