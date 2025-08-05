{ lib, ...}:
let
  inherit (lib) enabled;
in {
  # environment.systemPackages = [ package ];

  home-manager.sharedModules = [{
    programs.helix = enabled {
      settings.editor = {
        auto-completion = false;
        bufferline = "multiple";
        color-modes = true;
        cursorline = true;
        file-picker.hidden = false;
        soft-wrap.enable = true;
        idle-timeout = 0;
        line-number = "relative";
        shell = [ "zsh" "-c" ];
      };
    };
  }];
}
