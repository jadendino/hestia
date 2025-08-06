{ config, ... }:

{
  # currentHost preferences
  # i.e., the ones you see when running
  #       `$ defaults -currentHost read`
  
  system.defaults.CustomUserPreferences = {
    "/Users/${config.system.primaryUser}/Library/Preferences/ByHost/com.apple.Spotlight" = {
      MenuItemHidden = 1;
    };

    "/Users/${config.system.primaryUser}/Library/Preferences/ByHost/com.apple.controlcenter" = {
      AirDrop = 24;
      Bluetooth = 24;
      Display = 24;
      FocusModes = 24;
      NowPlaying = 2;
      Sound = 18;
      
      Battery = 6;
      BatteryShowEnergyMode = 1;
      BatteryShowPercentage = 1;
    };
  };
}
