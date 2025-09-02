{
  inputs,
  pkgs,
}: let
  inherit (pkgs) callPackage;
in rec {
  asciid = callPackage ./asciid {};
  barotrauma-modding-tool = pkgs.python3Packages.callPackage ./barotrauma-modding-tool {
    inherit dearpygui;
  };
  dearpygui = pkgs.python3Packages.callPackage ./dearpygui {};
  exabind = callPackage ./exabind {};
  ffmpegfs = callPackage ./ffmpegfs {};
  frankensteiner = callPackage ./frankensteiner {};
  glwall = callPackage ./glwall {inherit inputs;};
  header-gen = callPackage ./header-gen {};
  lutebot = callPackage ./lutebot {};
  qt6ct-kde = pkgs.kdePackages.callPackage ./qt6ct-kde {};
  slsk-batchdl = callPackage ./slsk-batchdl {};
  termpicker = callPackage ./termpicker {};
  vgamepad = pkgs.python3Packages.callPackage ./vgamepad {};
}
