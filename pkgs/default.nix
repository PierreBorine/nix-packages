{
  packages,
  inputs,
  pkgs,
  lib,
}: let
  inherit (pkgs) callPackage;
in {
  dusage = callPackage ./dusage {};
  frankensteiner = callPackage ./frankensteiner {};
  header-gen = callPackage ./header-gen {};
  h-m-m = callPackage ./h-m-m {inherit inputs;};
  lutebot = callPackage ./lutebot {};
}
