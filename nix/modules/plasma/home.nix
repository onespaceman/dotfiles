{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.klassy
  ];

  xdg.dataFile."color-schemes/Frankenstyle.colors".source = ./Frankenstyle.colors;

  programs = {
    plasma = {
      enable = true;
      configFile = {
        kdeglobals.KDE.ShowIconsInMenuItems = false;
        "klassy/klassyrc" = {
          ButtonColors = {
            ButtonColorsInactiveSameHoverPress = false;
            ButtonOverrideColorsActiveClose = ''{"BackgroundHover":[50,243,139,168],"BackgroundPress":[25,243,139,168],"IconNormal":[243,139,168],"OutlineHover":[243,139,168],"OutlinePress":[50,243,139,168]}'';
            ButtonOverrideColorsActiveMaximize = ''{"IconNormal":[166,227,161]}'';
            ButtonOverrideColorsActiveMinimize = ''{"IconNormal":[249,226,175]}'';
            ButtonOverrideColorsInactiveClose = ''{"BackgroundHover":[50,243,139,168],"BackgroundPress":[25,243,139,168],"IconNormal":[243,139,168],"OutlineHover":[243,139,168],"OutlinePress":[50,243,139,168]}'';
            ButtonOverrideColorsInactiveMaximize = ''{"IconNormal":[166,227,161]}'';
            ButtonOverrideColorsInactiveMinimize = ''{"IconNormal":[249,226,175]}'';
            CloseButtonIconColorActive = "AsSelected";
            CloseButtonIconColorInactive = "AsSelected";
          };
          Global.RefreshedConfig = "6.5.3";
          Style.SplitterProxyEnabled = true;
          SystemIconGeneration = {
            KlassyDarkIconThemeInherits = "Tela-dark";
            KlassyIconThemeInherits = "Tela-light";
          };
          Windeco.AnimationsSpeedRelativeSystem = 3;
          Windeco.MatchTitleBarToApplicationColor = true;
          WindowOutlineStyle = {
            WindowOutlineAccentColorOpacityActive = 100;
            WindowOutlineStyleActive = "WindowOutlineAccentColor";
            WindowOutlineThickness = 2;
          };
        };
      };
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
          screen = 0;
          location = "bottom";
          floating = true;
          widgets = [
            {
              name = "org.dhruv8sh.kara";
              config = {
                general = {
                  highlightOpacityFull = false;
                  highlightType = 0;
                  spacing = 0;
                };
                type1 = {
                  fixedLen = 1;
                  template = "%roman";
                };
              };
            }
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
          turnOffDisplay.idleTimeout = 600;
        };
      };
      session.general.askForConfirmationOnLogout = false;
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      windows.allowWindowsToRememberPositions = true;
      workspace = {
        colorScheme = "Frankenstyle";
        cursor = {
          theme = "breeze_cursors";
          size = 30;
          cursorFeedback = "None";
        };
        iconTheme = "Klassy";
        splashScreen.theme = "None";
        theme = "default";
        windowDecorations = {
          library = "org.kde.klassy";
          theme = "klassy";
        };
      };
    };
  };
}
