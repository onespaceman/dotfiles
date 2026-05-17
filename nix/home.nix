{
  lib,
  pkgs,
  ...
}: {
  home = {
    stateVersion = "26.05";
    username = "spaceman";
    homeDirectory = "/home/spaceman";
    packages = with pkgs; [
      nixd # nix LSP
      bash-language-server
      vscode-json-languageserver
      yaml-language-server
    ];
  };
  xdg.configFile = {
    "git".source = ../home/.config/git;
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
          bufferline = "multiple";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          default-yank-register = "+";
          indent-guides.render = true;
          line-number = "relative";
          # lsp settings
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "error";
            other-lines = "disable";
          };
        };
        keys = {
          insert = {
            "C-space" = "completion";
          };
          normal = {
            "e" = "extend_next_word_end";
            "E" = "extend_prev_word_end";
            "w" = "extend_next_word_start";
            "W" = "extend_prev_word_start";
            "X" = "select_line_above";
            "C-s" = ":write";
            "C-7" = "toggle_comments"; # 7=/ for some reason
            space."space" = "command_palette";
          };
        };
      };
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.alejandra;
        }
      ];
      themes.puccin = {
        inherits = "catppuccin_mocha";
        palette.base = "#191724";
        "warning" = {
          fg = "yellow";
          modifiers = ["dim"];
        };
        "error" = {
          fg = "red";
          modifiers = ["dim"];
        };
      };
    };
    nushell = {
      enable = true;
      configFile.source = ../home/.config/nushell/config.nu;
      environmentVariables.LS_COLORS = lib.hm.nushell.mkNushellInline "${pkgs.vivid}/bin/vivid generate catppuccin-mocha";
    };
  };
}
