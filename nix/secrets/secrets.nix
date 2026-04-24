let
  ship = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSpzkbduz4gpkjzgHVknjXNVCbpCDSnjDiH4vj5prSs spaceman@spaceman.one";
  mothership = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZQgoB5SIFfFy2h59D+zVHLjdo5tUX+BsUkAM4gwZj5 root@mothership";
in {
  "ups.age".publicKeys = [ship mothership]; 
}
