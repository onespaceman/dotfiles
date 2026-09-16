{
  config,
  pkgs,
  ...
}: let
  # Pull base caddy image
  caddyBase = pkgs.dockerTools.pullImage {
    imageName = "caddy";
    imageDigest = "sha256:df7f1c2fb114453b951de51a98efc010db1655a92c2e86be6706714e2417a78d";
    finalImageTag = "2";
    hash = "sha256-0uWUw2BoxCMNEP0xCSzaE2k7TiQkT0CrBN5YT2G2prE=";
  };
  # Build caddy binary with plugins
  caddyWithPlugins = pkgs.caddy.withPlugins {
    plugins = [
      "github.com/caddy-dns/cloudflare@v0.2.4"
      "github.com/lucaslorentz/caddy-docker-proxy/v2@v2.13.1"
      "github.com/mholt/caddy-dynamicdns@v0.0.0-20260805195708-67d107a42c02"
      "github.com/anujc4/caddy-geoblock@v0.1.2"
    ];
    hash = "sha256-sCdJ4yS/OgASyrRid6aClHl0pPPFOnHVbBeB/uLFD9s=";
  };
  # Build caddy image
  caddy = pkgs.dockerTools.buildImage {
    name = "caddy-custom";
    tag = "latest";
    fromImage = caddyBase;
    fromImageName = "caddy";
    fromImageTag = "2";
    copyToRoot = "${caddyWithPlugins}/bin";
    extraCommands = ''
      mkdir -p ./usr/bin
      mv ./caddy ./usr/bin/
    '';
    config = {
      Workdir = "/srv";
      Cmd = ["caddy" "docker-proxy"];
    };
  };

  geolite2Country = builtins.fetchurl {
    url = "https://github.com/P3TERX/GeoLite.mmdb/releases/download/2026.09.07/GeoLite2-Country.mmdb";
    sha256 = "sha256-RHEjFLb4vrYptF+orXy78EpV41KpHnWooYOA1i4lhhY=";
  };
in {
  # }: {
  networking.firewall.allowedTCPPorts = [80 443];
  age.secrets.caddy.file = ./caddy.age;

  virtualisation.oci-containers.containers.caddy = {
    image = "caddy-custom:latest";
    imageFile = caddy;
    # image = "ghcr.io/serfriz/caddy-cloudflare-ddns-crowdsec-geoip-security-dockerproxy:latest";
    hostname = "caddy";
    autoStart = true;
    environment = {
      CADDY_INGRESS_NETWORKS = "pub";
    };
    environmentFiles = [config.age.secrets.caddy.path];
    networks = ["pub"];
    ports = ["80:80" "443:443"];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/docker/caddy:/data"
      "${geolite2Country}:/GeoLite2-Country.mmdb"
    ];
    labels = {
      "caddy_0.dynamic_dns.provider" = "cloudflare {env.CLOUDFLARE_TOKEN}";
      "caddy_0.dynamic_dns.domains.spaceman\\.one" = "*";
      "caddy_0.dynamic_dns.versions" = "ipv6";
      "caddy_1" = "(common)";
      "caddy_1.geoblock.db_path" = "/GeoLite2-Country.mmdb";
      "caddy_1.geoblock.allow_countries" = "US";
    };
  };
}
