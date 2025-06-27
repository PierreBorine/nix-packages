{
  packages,
  inputs,
  pkgs,
  lib,
}: let
  inherit (pkgs) callPackage;
in {
  asciid = callPackage ./asciid {};
  barotrauma-modding-tool = pkgs.python3Packages.callPackage ./barotrauma-modding-tool {
    inherit (packages) dearpygui;
  };
  dearpygui = pkgs.python3Packages.callPackage ./dearpygui {};
  exabind = callPackage ./exabind {};
  frankensteiner = callPackage ./frankensteiner {};
  glwall = callPackage ./glwall {inherit inputs;};
  header-gen = callPackage ./header-gen {};
  lutebot = callPackage ./lutebot {};
  qt6ct-kde = pkgs.kdePackages.callPackage ./qt6ct-kde {};
  termpicker = callPackage ./termpicker {};
  vgamepad = pkgs.python3Packages.callPackage ./vgamepad {};
}
