let
  spaceman = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSpzkbduz4gpkjzgHVknjXNVCbpCDSnjDiH4vj5prSs spaceman@spaceman.one";
  mothership = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZQgoB5SIFfFy2h59D+zVHLjdo5tUX+BsUkAM4gwZj5 root@mothership";
  all = [spaceman mothership];
in {
  "nix/mothership/backup/restic.age".publicKeys = all;
  "nix/mothership/ups/ups.age".publicKeys = all;
  "nix/mothership/docker/caddy/caddy.age".publicKeys = all;
  "nix/mothership/docker/pocketid/pocketid.age".publicKeys = all;
  "nix/mothership/docker/miniflux/miniflux.age".publicKeys = all;
  "nix/mothership/docker/silverbullet/silverbullet.age".publicKeys = all;
}
