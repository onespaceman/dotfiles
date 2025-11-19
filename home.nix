{ config, pkgs, ... }:
{
  home = {
    stateVersion = "24.05";
    username = "spaceman";
    homeDirectory = "/home/spaceman";
    packages = with pkgs; [
      deno
    ];
  };
  xdg.configFile."git/config".source = ./home/.config/git/config;
  xdg.configFile."zsh" = {
    source = ./home/.config/zsh;
    recursive = true;
  };
  programs = {
    home-manager.enable = true;
    programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin_mocha";
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }];
    };
    tmux = {
      enable = true;
      mouse = true;
      prefix = "C-a";
      extraConfig =
        ''
          bind \\ split-window -h
          bind - split-window -v
          unbind '"'
          unbind %
        '';
    };
    zsh = {
      enable = true;
      initContent = builtins.readFile ./home/.zshrc;
      history = {
        path = "$HOME/.zhistory";
      };
      historySubstringSearch.enable = true;
      autosuggestion.enable = true;
    };
  };
}
