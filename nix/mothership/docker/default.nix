{pkgs, ...}: {
  imports = [
    ./arcane.nix
    ./beets.nix
    ./calibre.nix
    ./cloudflared.nix
    ./jellyfin.nix
    ./koito.nix
    ./miniflux.nix
    ./navidrome.nix
    ./rtorrent.nix
    ./searxng.nix
    ./silverbullet.nix
  ];

  users.users.spaceman.extraGroups = ["docker"];

  system.activationScripts.mkDockerNetworks = ''
    ${pkgs.docker}/bin/docker network create pub > /dev/null 2>&1 || true
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
}
