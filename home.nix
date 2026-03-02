{ config, pkgs, ... }:
{
  home = {
    stateVersion = "24.05";
    username = "spaceman";
    homeDirectory = "/home/spaceman";
    packages = with pkgs; [ ];
  };
  xdg.configFile."git/config".source = ./home/.config/git/config;
  xdg.configFile."nushell" = {
    source = ./home/.config/nushell;
    recursive = true;
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
