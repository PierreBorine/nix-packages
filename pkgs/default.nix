pkgs: let
  inherit (pkgs) callPackage python3Packages;

  final = {
    apex-tux = callPackage ./apex-tux {};
    asciid = callPackage ./asciid {};
    barotrauma-modding-tool = python3Packages.callPackage ./barotrauma-modding-tool {
      inherit (final) dearpygui;
    };
    barotrauma-save-decompressor = callPackage ./barotrauma-save-decompressor {};
    binbreak = callPackage ./binbreak {};
    curv = python3Packages.callPackage ./curv {};
    dearpygui = python3Packages.callPackage ./dearpygui {};
    exabind = callPackage ./exabind {};
    ffmpegfs = callPackage ./ffmpegfs {};
    frankensteiner = callPackage ./frankensteiner {};
    glwall = callPackage ./glwall {};
    h2mm-cli = callPackage ./h2mm-cli {};
    hd2arsenal = callPackage ./hd2arsenal {};
    header-gen = callPackage ./header-gen {};
    hushmic = callPackage ./hushmic {};
    hyprselect = callPackage ./hyprselect {};
    libloot-cpp = callPackage ./libloot-cpp {};
    loot = callPackage ./loot {inherit (final) libloot-cpp svg-to-ico;};
    lutebot = callPackage ./lutebot {};
    mo2-lint = python3Packages.callPackage ./mo2-lint {};
    slsk-batchdl = callPackage ./slsk-batchdl {};
    spotify-to-tidal = python3Packages.callPackage ./spotify-to-tidal {};
    svg-to-ico = callPackage ./svg-to-ico {};
    termpicker = callPackage ./termpicker {};
    vgamepad = python3Packages.callPackage ./vgamepad {};
    wakafetch = callPackage ./wakafetch {};
  };
in
  final
