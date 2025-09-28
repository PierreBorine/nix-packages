self: rec {
  default = all;
  all = apex-tux;
  apex-tux = import ./apex-tux/nixos.nix self;
}
