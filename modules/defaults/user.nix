{ ... }:

{
  # user preferences
  # i.e., the ones you see when running
  #       `$ defaults read`

  # Source:
  # https://github.com/nix-darwin/nix-darwin/tree/master/modules/system/defaults

  system.defaults.CustomUserPreferences = {
    "com.apple.finder" = {
      FXArrangeGroupViewBy = "Name";
    };
  };

  system.defaults.".GlobalPreferences" = {
    "com.apple.mouse.scaling" = -1.0;
  };
  
  system.defaults.LaunchServices = {
    LSQuarantine = false;
  };
  
  system.defaults.NSGlobalDomain = {
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;

    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticInlinePredictionEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;

    NSWindowShouldDragOnGesture = true;

    InitialKeyRepeat = 15;
    KeyRepeat = 2;
    "com.apple.keyboard.fnState" = true;

    "com.apple.trackpad.scaling" = 0.875;
    "com.apple.trackpad.forceClick" = false;

    "com.apple.springing.enabled" = true;
    "com.apple.springing.delay" = 0.2;

    "com.apple.swipescrolldirection" = false;

    NSDocumentSaveNewDocumentsToCloud = false;
  };

  system.defaults.menuExtraClock = {
    ShowSeconds = true;
  };

  
  system.defaults.dock = {
    autohide = true;
    
    enable-spring-load-actions-on-all-items = true;
    
    expose-animation-duration = 0.1;
    expose-group-apps = true;

    launchanim = false;
    mineffect = "scale";
    minimize-to-application = true;
    
    show-recents = false;
    mru-spaces   = false;

    orientation = "left";
    
    tilesize = 48;

    persistent-apps = [
      { app = "/System/Applications/Launchpad.app"; }
      { app = "/Applications/LibreWolf.app"; }
      { app = "/Applications/Ghostty.app"; }
      { app = "/System/Applications/Mail.app"; }
      { app = "/System/Applications/Calendar.app"; }
      { app = "/System/Applications/Reminders.app"; }
      { app = "/System/Applications/Notes.app"; }
      { app = "/System/Applications/System Settings.app"; }
    ];

    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };

  system.defaults.finder = {
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;

    NewWindowTarget = "Home";

    _FXShowPosixPathInTitle = true;
    _FXSortFoldersFirst = true;

    ShowPathbar = true;
    ShowStatusBar = true;
    CreateDesktop = false;
  };

  system.defaults.hitoolbox.AppleFnUsageType = "Change Input Source";


  system.defaults.trackpad = {
    FirstClickThreshold = 0;
  };

}

