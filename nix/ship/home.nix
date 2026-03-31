{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      blender
      ffmpeg
      iosevka
      krita
      qview
    ];
  };

  xdg.configFile = {
    "mpv" = {
      source = ../../home/.config/mpv;
      recursive = true;
    };
  };

  programs = {
    firefox = {
      enable = true;
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
        search = {
          force = true;
          default = "dgg";
          privateDefault = "dgg";
        };
        settings = {
          toolkit.legacyUserProfileCustomizations.stylesheets = true;
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

    plasma = {
      enable = true;
      krunner = {
        position = "center";
        shortcuts.launch = "Meta";
      };
      kwin = {
        cornerBarrier = false;
        edgeBarrier = 0;
        effects.shakeCursor.enable = false;
        titlebarButtons = {
          left = [ ];
          right = [
            "help"
            "minimize"
            "maximize"
            "close"
          ];
        };
      };
      panels = [
        {
          location = "bottom";
          widgets = [
            "org.kde.plasma.panelspacer"
            {
              kickoff = {
                sortAlphabetically = true;
                compactDisplayStyle = true;
                showActionButtonCaptions = false;
                settings.switchCategoryOnHover = true;
              };
            }
            {
              iconTasks = {
                launchers = [
                  "preferred://browser"
                  "preferred://filemanager"
                  "applications:foot.desktop"
                  "applications:vesktop.desktop"
                  "applications:steam.desktop"
                ];
                appearance.indicateAudioStreams = false;
              };
            }
            "org.kde.plasma.panelspacer"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.volume"
                ];
                hidden = [
                  "org.kde.plasma.disks"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                ];
              };
            }
            "org.kde.plasma.digitalclock"
          ];
        }
      ];
      powerdevil = {
        AC = {
          powerButtonAction = "showLogoutScreen";
          autoSuspend.action = "nothing";
          turnOffDisplay.idleTimeout = 15000;
        };
      };
      workspace = {
        colorScheme = "Scratchy";
        cursor = {
          theme = "breeze_cursors";
          size = 30;
        };
        iconTheme = "Tela-dark";
        splashScreen.theme = "None";
        theme = "Scratchy";
        windowDecorations = {
          library = "org.kde.kwin.aurorae.v2";
          theme = "__aurorae__svg__Scratchy";
        };
      };
    };

    vesktop = {
      enable = true;
      vencord.settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        minimizeToTray = true;
        notifyAboutUpdates = true;
        plugins = {
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
