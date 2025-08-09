{ pkgs, dots, ...}:

{
  environment.systemPackages = [ pkgs.helix ];

  home-manager.sharedModules = [{   
    xdg.configFile."helix" = {
      recursive = true;
      source = "${dots}/helix";
    };
  }];
}
