{ config, pkgs, ... }:
{
  home = {
    stateVersion = "26.05";
    username = "spaceman";
    homeDirectory = "/home/spaceman";
    packages = with pkgs; [
      nil # nix LSP
      bash-language-server
    ];
  };
  xdg.configFile = {
    "git/config".source = ../home/.config/git/config;
    "tmux/tmux.conf".source = ../home/.config/tmux/tmux.conf;
    "nushell/autoload/theme.nu".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/nushell/refs/heads/main/themes/catppuccin_mocha.nu";
      sha256 = "8ba6876bc110418578c77b846d97af9b0b5e5d78f7fb81e25bc5b00db7324603";
    };
  };
  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
      ignoreCase = true;
    };
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
    helix = {
      enable = true;
      settings = {
        theme = "puccin";
        editor = {
          default-yank-register = "+";
          indent-guides.render = true;
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };
      themes.puccin = {
        inherits = "catppuccin_mocha";
        palette.base = "#191724";
      };
    };
    nushell = {
      enable = true;
      configFile.source = ../home/.config/nushell/config.nu;
    };
  };
}
