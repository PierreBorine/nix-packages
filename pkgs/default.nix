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
  glwall = callPackage ./glwall {};
  header-gen = callPackage ./header-gen {};
  h-m-m = callPackage ./h-m-m {inherit inputs;};
  lutebot = callPackage ./lutebot {};
  termpicker = callPackage ./termpicker {};
  vgamepad = pkgs.python3Packages.callPackage ./vgamepad {};
}
