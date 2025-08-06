{ ... }:

{
  system.defaults.CustomUserPreferences = {
    "com.apple.Safari" = {
      AlwaysRestoreSessionAtLaunch = 0;
      AutoOpenSafeDownloads = 0;
      DownloadsClearingPolicy = 1;
      ExcludePrivateWindowWhenRestoringSessionAtLaunch = 1;
      OpenPrivateWindowWhenNotRestoringSessionAtLaunch = 1;
      HistoryAgeInDaysLimit = 365000; # really?
      ShowFullURLInSmartSearchField = 1;
      UniversalSearchEnabled = 0;
      UseHTTPSOnly = 1;
    };
  };
}
