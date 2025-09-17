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
    neovim = {
      enable = true;
      extraLuaConfig =
      ''
      vim.opt.cursorline = true
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.termguicolors = true
      '';
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
