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
      extraConfig =
        let
          scripts = "${pkgs.nu_scripts}/share/nu_scripts";
        in
        ''
          source ${scripts}/themes/nu-themes/catppuccin-mocha.nu
          # theme overrides
          export-env {
            $env.config.color_config.background = "#191724"
            ($"(ansi -o '11;')('#191724')(char bel)" | print -n $"($in)\r")
          }
        '';
    };
  };
}
