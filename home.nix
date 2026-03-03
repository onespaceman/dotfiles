{ config, pkgs, ... }:
{
  home = {
    stateVersion = "24.05";
    username = "spaceman";
    homeDirectory = "/home/spaceman";
    packages = with pkgs; [ ];
  };
  xdg.configFile = {
    "git/config".source = ./home/.config/git/config;
    "nushell" = {
      source = ./home/.config/nushell;
      recursive = true;
    };
    "nushell/autoload/imports.nu".text = let
      scripts = "${pkgs.nu_scripts}/share/nu_scripts";
    in ''
      source ${scripts}/custom-completions/git/git-completions.nu
      source ${scripts}/custom-completions/nix/nix-completions.nu
      source ${scripts}/custom-completions/ssh/ssh-completions.nu
      source ${scripts}/custom-completions/docker/docker-completions.nu
    '';
  };
  programs = {
    direnv.enable = true;
    home-manager.enable = true;
    helix = {
      enable = true;
      settings = {
        theme = "catppuccin_mocha";
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    nushell = {
      enable = true;
    };
  };
}
