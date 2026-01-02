self: rec {
  default = apex-tux;
  apex-tux = import ./apex-tux/nixos.nix self;
}
