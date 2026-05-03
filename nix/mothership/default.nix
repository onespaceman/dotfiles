{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./backup.nix
    ./docker
    ./samba.nix
    ./ups.nix
  ];

  # Boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = [
        "data1"
        "data2"
        "data3"
        "seagatemirror"
      ];
    };
  };

  powerManagement.cpuFreqGovernor = "ondemand";
  services.smartd.enable = true;

  # Filesystems
  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home" = {
      neededForBoot = true;
      options = ["compress=zstd"];
    };
    "/nix".options = ["compress=zstd" "noatime"];
    "/swap".options = ["noatime"];
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
      fileSystems = ["/"];
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
      extraCommands = "iptables -I nixos-fw 1 -i br+ -j ACCEPT"; # allow docker networks
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
