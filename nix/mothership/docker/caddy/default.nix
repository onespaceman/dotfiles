{
  config,
  lib,
  pkgs,
  ...
}: let
  # Pull base caddy image
  caddyBase = pkgs.dockerTools.pullImage {
    imageName = "caddy";
    imageDigest = "sha256:f2a1290d0463aad60660d4ec134943f183ee2a5f6c3eb7bf32dd984f2f020772";
    finalImageTag = "2";
    hash = "sha256-pC6qqWAS40OVc2SjVBFjiyHt6jDwXsdCF8v/6LuMiPY=";
  };
  # Build caddy binary with plugins
  caddyWithPlugins = pkgs.caddy.withPlugins {
    plugins = [
      "github.com/corazawaf/coraza-caddy/v2@v2.6.2"
      "github.com/caddy-dns/cloudflare@v0.2.4"
      "github.com/lucaslorentz/caddy-docker-proxy/v2@v2.13.1"
      "github.com/mholt/caddy-dynamicdns@v0.0.0-20260805195708-67d107a42c02"
      "github.com/anujc4/caddy-geoblock@v0.1.2"
    ];
    hash = "sha256-OsV7UfR0gu0C18/tglS6na8xSBHSq2IQ7MSLyxnnfTA=";
  };
  # Build caddy image
  caddy = pkgs.dockerTools.buildImage {
    name = "caddy-custom";
    tag = "latest";
    fromImage = caddyBase;
    fromImageName = "caddy";
    fromImageTag = "2";
    copyToRoot = pkgs.buildEnv {
      name = "image-root";
      paths = [
        (pkgs.runCommand "configs" {} ''
          mkdir -p $out/config
          ln -s ${baseConfig} $out/config/base.caddy
          ln -s ${geolite2Country} $out/config/GeoLite2-Country.mmdb
        '')
        caddyWithPlugins
      ];
      pathsToLink = ["/bin" "/config"];
    };
    config = {
      Workdir = "/srv";
      Cmd = ["/bin/caddy" "docker-proxy"];
    };
  };

  # Maxmind geolite database
  geolite2Country = builtins.fetchurl {
    url = "https://github.com/P3TERX/GeoLite.mmdb/releases/download/2026.10.10/GeoLite2-Country.mmdb";
    sha256 = "sha256:07g5m40m97j8wlrgspza3w50wh6wriszgqy2a0lkli642bj7hl33";
  };

  baseConfig = pkgs.writeText "caddy_config" ''
    {
    	dynamic_dns {
    		domains {
    			{$URL} *
    		}
    		provider cloudflare {env.CLOUDFLARE_TOKEN}
    		versions ipv6
    	}
    	order coraza_waf first
    }
    (common) {
    	geoblock {
    		allow_countries US
    		db_path /config/GeoLite2-Country.mmdb
    	}
    	coraza_waf {
    		load_owasp_crs
    		directives `
         Include @coraza.conf-recommended
         Include @crs-setup.conf.example
         Include @owasp_crs/*.conf
         SecRuleEngine On
        `
    		tx_id_req_header X-Transaction-ID
    	}
    }
    *.{$URL} {
    	tls {
    		dns cloudflare {env.CLOUDFLARE_TOKEN}
    	}
      abort
    }
  '';
in {
  networking.firewall.allowedTCPPorts = [80 443];
  age.secrets.caddy.file = ./caddy.age;

  virtualisation.oci-containers.containers.caddy = {
    image = "caddy-custom:latest";
    imageFile = caddy;
    # image = "ghcr.io/serfriz/caddy-cloudflare-ddns-crowdsec-geoip-security-dockerproxy:latest";
    hostname = "caddy";
    autoStart = true;
    autoRemoveOnStop = false;
    environment = {
      CADDY_INGRESS_NETWORKS = "pub";
      CADDY_DOCKER_CADDYFILE_PATH = "/config/base.caddy";
    };
    environmentFiles = [config.age.secrets.caddy.path];
    networks = ["pub"];
    ports = ["80:80" "443:443"];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/docker/caddy:/data"
    ];
  };
}
