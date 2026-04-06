# Base config
{
  config,
  lib,
  pkgs,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system = {
    stateVersion = "24.05";
  };

  time.timeZone = "America/New_York";

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

  # Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.spaceman.imports = [ ./home.nix ];
  };
}
