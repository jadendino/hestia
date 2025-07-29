{
  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];

    flake-registry           = "";
    http-connections         = 50;
    lazy-trees               = true;
    show-trace               = true;
    trusted-users            = [ "root" "@build" "@wheel" "@admin" ];
    warn-dirty               = false;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, nix-darwin, ... }:
  let
    inherit (builtins) readDir;
    inherit (nixpkgs.lib) mapAttrs;

    lib' = nixpkgs.lib.extend (_: _: nix-darwin.lib);
    lib  = lib'.extend <| import ./lib inputs;

    hostConfigs = readDir ./hosts
      |> mapAttrs (name: _: import ./hosts/${name} lib);

  in {
    inherit lib;
    darwinConfigurations = hostConfigs;
  };
}
