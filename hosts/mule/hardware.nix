{
  nixpkgs.hostPlatform = "aarch64-darwin";
  # nix-darwin wants to manage nix, but Determinate Nix already
  # does that, so we disable the functionality.
  nix.enable = false;
}
