{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./docker.nix
    ./samba.nix
  ];

  # Boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    supportedFilesystems = [ "zfs" ];
    zfs.extraPools = [
      "data1"
      "data3"
    ];
  };

  # Filesystems
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/swap".options = [ "noatime" ];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };

  # Keyboard layout
  services.xserver.xkb.layout = "us";

  # Networking
  networking = {
    firewall = {
      enable = true;
      allowPing = true;
      extraCommands = "iptables -I nixos-fw 1 -i br+ -j ACCEPT";
    };
    hostId = "1e1e1e1e";
    hostName = "mothership";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  # Audio
  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Power
  powerManagement.cpuFreqGovernor = "ondemand";

  # Spin down drives
  services.udev.extraRules =
    let
      mkRule = as: lib.concatStringsSep ", " as;
      mkRules = rs: lib.concatStringsSep "\n" rs;
    in
    mkRules ([
      (mkRule [
        ''ACTION=="add|change"''
        ''SUBSYSTEM=="block"''
        ''KERNEL=="sd[a-z]"''
        ''ATTR{queue/rotational}=="1"''
        ''RUN+="${pkgs.hdparm}/bin/hdparm -B 90 -S 61 /dev/%k"''
      ])
    ]);

  power.ups = {
    enable = true;
    mode = "standalone";
    ups."apc" = {
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
    users."admin" = {
      passwordFile = config.age.secrets.ups.path;
      upsmon = "primary";
    };
    upsmon = {
      monitor."apc" = {
        system = "apc@localhost";
        powerValue = 1;
        user = "admin";
        passwordFile = config.age.secrets.ups.path;
        type = "primary";
      };
      settings = {

      };
    };
  };

  # Services
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    extraConfig = ''
      Match Address 10.0.0.0/24
        PasswordAuthentication yes
    '';
  };
  # required for openssh match address to work
  security.pam.services.sshd.unixAuth = lib.mkForce true;
}
