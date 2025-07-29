{
  # Source:
  # https://github.com/nix-darwin/nix-darwin/tree/master/modules/system/defaults
  #
  # TODO: it might be wise to convert everything into a custom pref,
  # this abstraction layer between nix-darwin and the preferences doesn't
  # seem to useful. TBD.

  system.defaults.CustomSystemPreferences = {
    "com.apple.AdLib" = {
      allowApplePersonalizedAdvertising = false;
      allowIdentifierForAdvertising     = false;
      forceLimitAdTracking              = true;
      personalizedAdsMigrated           = false;
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

    NSDocumentSaveNewDocumentsToCloud = false;
  };

  system.defaults.menuExtraClock = {
    ShowSeconds = true;
  };

  system.defaults.controlcenter = {
    BatteryShowPercentage = true;
    Sound = false;
    Bluetooth = false;
    AirDrop = false;
    Display = false;
    FocusModes = false;
    NowPlaying = true;
  };
  
  system.defaults.dock = {
    autohide = true;
    
    enable-spring-load-actions-on-all-items = true;
    
    expose-animation-duration = 0.1;

    launchanim = false;
    mineffect = "scale";
    minimize-to-application = true;
    
    show-recents = false;
    mru-spaces   = false;

    orientation = "left";
  };

  system.defaults.finder = {
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;
    ShowPathbar = true;
    CreateDesktop = false;
  };

  system.defaults.hitoolbox.AppleFnUsageType = "Change Input Source";

  system.defaults.loginwindow = {
    GuestEnabled = false;
    DisableConsoleAccess = true;
  };

  system.defaults.trackpad = {
    FirstClickThreshold = 0;
  };
}
