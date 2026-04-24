# Base config
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./secrets/mysecrets.nix ]; 
  nixpkgs.config.allowUnfree = true;
  nix = {
    extraOptions = ''warn-dirty = false'';
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system = {
    stateVersion = "24.05";
    activationScripts.diff = {
      supportsDryActivation = true;
      text = ''${lib.getExe pkgs.nvd} --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"'';
    };
  };

  time.timeZone = "America/New_York";

  environment = {
    systemPackages = with pkgs; [
      curl
      direnv
      git
      home-manager
      helix
      htop
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

  # Users
  users.users.spaceman = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "storage"
      "wheel"
    ];
    createHome = true;
    hashedPassword = "$y$j9T$.oBXCoD8or9FJNQLQxAVU/$oe0TW9EJWgMRLsFmh7GQXkVBQdF4Ll6QsLnp/dnPjk6";
  };

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
