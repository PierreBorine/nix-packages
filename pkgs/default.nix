{
  packages,
  inputs,
  pkgs,
  lib,
}: let
  inherit (pkgs) callPackage;
in {
  barotrauma-modding-tool = pkgs.python3Packages.callPackage ./barotrauma-modding-tool {
    inherit (packages) dearpygui;
  };
  dearpygui = pkgs.python3Packages.callPackage ./dearpygui {};
  frankensteiner = callPackage ./frankensteiner {};
  glwall = callPackage ./glwall {inherit inputs;};
  header-gen = callPackage ./header-gen {};
  h-m-m = callPackage ./h-m-m {inherit inputs;};
  lutebot = callPackage ./lutebot {};
  termpicker = callPackage ./termpicker {};
  vgamepad = pkgs.python3Packages.callPackage ./vgamepad {};
}
