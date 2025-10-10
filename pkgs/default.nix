{
  inputs,
  callPackage,
  python3Packages,
  kdePackages,
}: rec {
  apex-tux = callPackage ./apex-tux {inherit inputs;};
  asciid = callPackage ./asciid {};
  barotrauma-modding-tool = python3Packages.callPackage ./barotrauma-modding-tool {
    inherit dearpygui;
  };
  barotrauma-save-decompressor = callPackage ./barotrauma-save-decompressor {};
  dearpygui = python3Packages.callPackage ./dearpygui {};
  exabind = callPackage ./exabind {};
  ffmpegfs = callPackage ./ffmpegfs {};
  frankensteiner = callPackage ./frankensteiner {};
  glwall = callPackage ./glwall {};
  h2mm-cli = callPackage ./h2mm-cli {};
  header-gen = callPackage ./header-gen {};
  lutebot = callPackage ./lutebot {};
  qt6ct-kde = kdePackages.callPackage ./qt6ct-kde {};
  reddix = callPackage ./reddix {};
  slsk-batchdl = callPackage ./slsk-batchdl {};
  termpicker = callPackage ./termpicker {};
  vgamepad = python3Packages.callPackage ./vgamepad {};
}
