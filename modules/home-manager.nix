{ lib, ... }: let
  inherit (lib) enabled;
in {
  home-manager = {
    useGlobalPkgs   = true;
    useUserPackages = true;
  };
}
