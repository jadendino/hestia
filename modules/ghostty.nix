{ lib, pkgs, ...}:
let
  inherit (lib) enabled;
in {
  homebrew.casks = [ "ghostty" ];

  home-manager.sharedModules = [{
    programs.ghostty = enabled {
      package = null;
      settings = {
        scrollback-limit = 100 * 1024 * 1024;
      };
    };
  }];
}
