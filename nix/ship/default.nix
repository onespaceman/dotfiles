{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./plasma
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "ship";

  # Boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    plymouth = {
      enable = true;
      theme = "circle_alt";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "circle_alt" ];
        })
      ];
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 32 * 1024; # 16GB
      options = [ "discard" ];
    }
  ];

  # Filesystems
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home" = {
      neededForBoot = true;
      options = [ "compress=zstd" ];
    };
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  # Keyboard layout
  services.xserver.xkb.layout = "us";

  # Graphics
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Audio
  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Games
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  # Remote
  environment.systemPackages = [ pkgs.rustdesk-flutter ];
  # systemd.services.rustdesk = {
  #   enable = true;
  #   description = "RustDesk";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "systemd-user-sessions.service" ];
  #   requires = [ "network.target" ];
  #   script = ''
  #     export PATH=/run/wrappers/bin:$PATH
  #     ${pkgs.rustdesk-flutter.outPath}/bin/rustdesk --service
  #   '';
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStop = "${pkgs.procps.outPath}/bin/pkill -f \"rustdesk --\"";
  #     PIDFile = "/run/rustdesk.pid";
  #     KillMode = "mixed";
  #     TimeoutStopSec = 30;
  #     User = "root";
  #     LimitNOFILE = 100000;
  #     Environment = [
  #       "PULSE_LATENCY_MSEC=60"
  #       "PIPEWIRE_LATENCY=1024/48000"
  #     ];
  #   };
  # };
}
