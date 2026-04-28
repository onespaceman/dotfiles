let
  spaceman = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSpzkbduz4gpkjzgHVknjXNVCbpCDSnjDiH4vj5prSs spaceman@spaceman.one";
  mothership = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZQgoB5SIFfFy2h59D+zVHLjdo5tUX+BsUkAM4gwZj5 root@mothership";
  all = [ spaceman mothership ];
in {
  "arcane.age".publicKeys = all;
  "cloudflare.age".publicKeys = all;
  "koito.age".publicKeys = all;
  "miniflux.age".publicKeys = all;
  "silverbullet.age".publicKeys = all;
  "ups.age".publicKeys = all;
}
