{ config, pkgs, ... }:
{
  imports = [ ./plasma/home.nix ];

  home = {
    packages = with pkgs; [
      blender
      ffmpeg
      iosevka
      kara # plasma panel nav
      klassy
      krita
      qview
      transmission_4-qt6
    ];
  };

  xdg = {
    configFile = {
      "mpv" = {
        source = ../../home/.config/mpv;
        recursive = true;
      };
    };
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/desk";
      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/dl";
      music = "${config.home.homeDirectory}/mus";
      pictures = "${config.home.homeDirectory}/pic";
      videos = "${config.home.homeDirectory}/vid";
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      policies = {
        DisableSetDesktopBackground = true;
        DisablePocket = true;
        DisableTelemetry = true;
        OfferToSaveLogins = false;
        FirefoxHome = {
          SponsoredTopSites = false;
          Highlights = false;
          Stories = false;
          SponsoredStories = false;
          Snippets = false;
        };
        FirefoxSuggest.SponsoredSuggestions = false;
        GenerativeAI.Enabled = false;
        NoDefaultBookmarks = true;
        OfferToSaveLoginsDefault = false;
      };
      profiles.default = {
        userChrome = builtins.readFile ../../userChrome.css;
        containers = { };
        containersForce = true;
        search = {
          force = true;
          default = "dgg";
          privateDefault = "dgg";
        };
        settings = {
          toolkit.legacyUserProfileCustomizations.stylesheets = true;
          browser.fixup.dns_first_for_single_words = true;
          browser.ml.linkPreview.enabled = false;
        };
      };
    };

    foot = {
      enable = true;
      settings = {
        main = {
          shell = "/run/current-system/sw/bin/tmux";
          font = "Iosevka:size=12";
          initial-window-size-chars = "170x35";
        };
        cursor.style = "beam";
        scrollback.lines = 10000;
        key-bindings = {
          clipboard-paste = "Control+v XF86Paste";
        };
        colors-dark = {
          background = "191724";
          foreground = "cdd6f4";
          regular0 = "45475a"; # black
          regular1 = "f38ba8"; # red
          regular2 = "a6e3a1"; # green
          regular3 = "f9e2af"; # yellow
          regular4 = "89b4fa"; # blue
          regular5 = "cba6f7"; # magenta
          regular6 = "94e2d5"; # cyan
          regular7 = "bac2de"; # white
        };
      };
    };

    mpv = {
      enable = true;
      scripts = [
        pkgs.mpvScripts.uosc
        pkgs.mpvScripts.thumbfast
      ];
    };

    vesktop = {
      enable = true;
      vencord.settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        minimizeToTray = true;
        notifyAboutUpdates = true;
        plugins = {
          AlwaysTrust.enabled = true;
          ClearURLs.enabled = true;
          FixYoutubeEmbeds.enabled = true;
        };
        extraQuickCss = "[href='/quest-home'] { display: none; }";
      };
    };

    zed-editor = {
      enable = true;
    };
  };

}
