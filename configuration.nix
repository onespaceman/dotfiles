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
  system.stateVersion = "24.05";
  environment.systemPackages = with pkgs; [
    curl
    git
    home-manager
    neovim
    tree
    wget
    zsh

    # archives
    zip
    unzip
    xz
  ];

  environment.variables.EDITOR = "nvim";
  programs = {
    zsh.enable =  true;
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };

  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
