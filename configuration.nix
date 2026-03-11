# NixOS for WSL2
{
  config,
  lib,
  pkgs,
  ...
}:
{
  wsl = {
    enable = true;
    defaultUser = "spaceman";
    wslConf.interop.appendWindowsPath = false;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
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

  environment = {
    systemPackages = with pkgs; [
      curl
      direnv
      git
      home-manager
      helix
      tmux
      tree
      wget

      # archives
      zip
      unzip
      xz
    ];
    variables.EDITOR = "hx";
    shells = [ pkgs.nushell ];
  };

  programs.bash.interactiveShellInit = ''
    if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
      exec nu
    fi
  '';

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
