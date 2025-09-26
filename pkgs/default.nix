{
  inputs,
  pkgs,
}: let
  inherit (pkgs) callPackage;
in rec {
  apex-tux = callPackage ./apex-tux {inherit inputs;};
  asciid = callPackage ./asciid {};
  barotrauma-modding-tool = pkgs.python3Packages.callPackage ./barotrauma-modding-tool {
    inherit dearpygui;
  };
  barotrauma-save-decompressor = callPackage ./barotrauma-save-decompressor {};
  dearpygui = pkgs.python3Packages.callPackage ./dearpygui {};
  exabind = callPackage ./exabind {};
  ffmpegfs = callPackage ./ffmpegfs {};
  frankensteiner = callPackage ./frankensteiner {};
  glwall = callPackage ./glwall {inherit inputs;};
  h2mm-cli = callPackage ./h2mm-cli {inherit inputs;};
  header-gen = callPackage ./header-gen {};
  lutebot = callPackage ./lutebot {};
  qt6ct-kde = pkgs.kdePackages.callPackage ./qt6ct-kde {};
  slsk-batchdl = callPackage ./slsk-batchdl {};
  termpicker = callPackage ./termpicker {};
  vgamepad = pkgs.python3Packages.callPackage ./vgamepad {};
}
