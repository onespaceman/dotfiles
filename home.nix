{ config, pkgs, ... }:
{
  home = {
    stateVersion = "24.05";
    username = "spaceman";
    homeDirectory = "/home/spaceman";
  };
  xdg.configFile."git/config".source = ./home/.config/git/config;
  xdg.configFile."zsh" = {
    source = ./home/.config/zsh;
    recursive = true;
  };
  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      initExtra = builtins.readFile ./home/.zshrc;
      history = {
        path = "$HOME/.zhistory";
      };
      historySubstringSearch.enable = true;
      autosuggestion.enable = true;
    };
  };
}
