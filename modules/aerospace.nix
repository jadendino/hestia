{ dots, ...}:

{
  homebrew.taps = [ "nikitabobko/tap" ];
  homebrew.casks = [ "nikitabobko/tap/aerospace" ];
  home-manager.sharedModules = [{
    xdg.configFile."aerospace" = {
      recursive = true;
      source = "${dots}/aerospace";
    };
  }];
}
