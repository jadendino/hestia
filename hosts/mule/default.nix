lib: lib.darwinSystem' ({ config, lib, ... }: let
  inherit (lib) collectNix remove;
in {
  imports = collectNix ./.
    |> remove ./default.nix;

  networking.hostName = "mule";

  system.primaryUser = "jad";
  users.users.jad = {
    name = "jad";
    home = "/Users/jad";
  };

  home-manager.users.jad.home = {
    stateVersion  = "25.11";
    homeDirectory = config.users.users.jad.home;
  };
  
  system.stateVersion = 6;
})
