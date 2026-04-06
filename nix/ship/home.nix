{ config, pkgs, ... }:
{
  imports = [ ../modules/plasma/home.nix ];

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
