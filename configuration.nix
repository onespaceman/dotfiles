# NixOS for WSL2
{ 
  config,
  lib,
  pkgs,
  ...
}: {
  wsl = {
    enable = true;
    defaultUser = "spaceman";
    wslConf.interop.appendWindowsPath = false;
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system = {
    stateVersion = "24.05";
    autoUpgrade = {
      enable = true;
      flake = "github:onespaceman/dotfiles";
      flags = [
        "--print-build-logs"
      ];
      randomizedDelaySec = "45min";
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    home-manager
    helix
    tmux
    tree
    wget
    zsh

    # archives
    zip
    unzip
    xz
  ];

  environment.variables.EDITOR = "hx";
  programs = {
    zsh.enable =  true;
  };

  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
