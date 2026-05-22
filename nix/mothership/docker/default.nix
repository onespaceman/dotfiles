{pkgs, ...}: {
  imports = [
    ./beets.nix
    ./calibre.nix
    ./cloudflared.nix
    ./docky.nix
    ./jellyfin.nix
    ./git.nix
    ./koito.nix
    ./miniflux.nix
    ./navidrome.nix
    ./rtorrent.nix
    ./searxng.nix
    ./silverbullet.nix
  ];

  users.users.spaceman.extraGroups = ["docker"];

  system.activationScripts.mkDockerNetworks = ''
    ${pkgs.docker}/bin/docker network create --ipv6 pub > /dev/null 2>&1 || true
    ${pkgs.docker}/bin/docker network create --internal priv > /dev/null 2>&1 || true
  '';

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings.dns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    oci-containers.backend = "docker";
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
      if (subject.isInGroup("docker") &&
        action.id == "org.freedesktop.systemd1.manage-units" &&
        action.lookup("unit").startsWith("docker-")
      ) {
        return polkit.Result.YES;
      }
    });
  '';
}
