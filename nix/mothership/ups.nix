{config, ...}: {
  age.secrets.ups.file = ../secrets/ups.age;

  power.ups = {
    enable = true;
    mode = "standalone";
    ups."apc" = {
      description = "APC";
      driver = "usbhid-ups";
      port = "auto";
      directives = [
        "offdelay = 60"
        "ondelay = 70"
        "lowbatt = 40"
        "ignorelb"
      ];
    };
    upsd.listen = [
      {
        address = "127.0.0.1";
        port = 3493;
      }
    ];
    users."nut-admin" = {
      passwordFile = config.age.secrets.ups.path;
      upsmon = "primary";
    };
    upsmon.monitor."apc" = {
      system = "apc@localhost";
      powerValue = 1;
      user = "nut-admin";
      passwordFile = config.age.secrets.ups.path;
      type = "primary";
    };
  };
}
