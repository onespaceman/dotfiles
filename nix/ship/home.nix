{
  config,
  pkgs,
  ...
}: {
  imports = [./plasma/home.nix];

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
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        SearchEngines = {
          Default = "searchy";
          Add = [
            {
              Name = "searchy";
              Description = "searchy";
              IconURL = "https://s.spaceman.one/static/themes/simple/img/favicon.png";
              URLTemplate = "https://s.spaceman.one/search?q={searchTerms}";
            }
          ];
          Remove = [
            "Amazon"
            "Amazon.com"
            "Bing"
            "eBay"
            "Perplexity"
          ];
        };
      };
      profiles.default = {
        userChrome = builtins.readFile ../../userChrome.css;
        containers = {};
        containersForce = true;
        # search = {
        #   force = true;
        #   default = "searchy";
        #   privateDefault = "searchy";
        #   engines = {
        #     searchy = {
        #       name = "searchy";
        #       iconurl = "https://s.spaceman.one/static/themes/simple/img/favicon.png";
        #       urls = [{template = "https://s.spaceman.one/search?q={searchTerms}";}];
        #     };
        #     amazondotcom-us.metadata.hidden = true;
        #     bing.metadata.hidden = true;
        #   };
        # };
        settings = {
          browser.ml.linkPreview.enabled = false;
          toolkit.legacyUserProfileCustomizations.stylesheets = true;
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
