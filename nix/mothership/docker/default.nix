{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./beets.nix
    ./calibre.nix
    ./caddy
    ./dockhand.nix
    ./git.nix
    ./jellyfin.nix
    ./miniflux
    ./navidrome.nix
    ./pocketid
    ./rt.nix
    ./searxng.nix
    ./scrobbles.nix
    ./silverbullet
  ];

  users.users.spaceman.extraGroups = ["docker"];

  networking.firewall.extraCommands = "iptables -I nixos-fw 1 -i br+ -j ACCEPT"; # allow docker networks

  # Create docker networks
  system.activationScripts.mkDockerNetworks = ''
    ${pkgs.docker}/bin/docker network create --ipv6 pub > /dev/null 2>&1 || true
    ${pkgs.docker}/bin/docker network create --internal priv > /dev/null 2>&1 || true
  '';

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        ipv6 = true;
      };
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    oci-containers.backend = "docker";
  };
}
