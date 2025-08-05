{ lib, ...}:
let
  inherit (lib) mkAfter;
in {
  homebrew.taps = [ "nikitabobko/tap" ];
  homebrew.casks = [ "nikitabobko/tap/aerospace" ];
}
