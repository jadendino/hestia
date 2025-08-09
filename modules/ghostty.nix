{ dots, ...}:

{
  homebrew.casks = [ "ghostty" ];

  home-manager.sharedModules = [{
    xdg.configFile."ghostty" = {
      recursive = true;
      source = "${dots}/ghostty";
    };
  }];
}
