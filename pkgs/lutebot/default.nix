{
  lib,
  stdenvNoCC,
  fetchzip,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
  protontricks,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "lutebot";
  version = "3.6.4"; # 3.6.5 kinda broke lutemod

  src = fetchzip {
    url = "https://github.com/Dimencia/LuteBot3/releases/download/v${finalAttrs.version}/LuteBot.${finalAttrs.version}.zip";
    hash = "sha256-R8Zx7WU0/n+rPRmSDlK4s1IT5yfgkHSzGDIffYevZ3M=";
  };

  nativeBuildInputs = [copyDesktopItems makeWrapper];

  desktopItems = [
    (makeDesktopItem {
      name = "LuteBot";
      desktopName = "LuteBot";
      genericName = "Mordhau Music Tool";
      exec = "lutebot";
      icon = ./mordhau.png;
      terminal = false;
      categories = ["Application" "Game" "Utility" "Audio"];
    })
  ];

  phases = ["installPhase"];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share

    cp -r $src/bin/Release/net7.0-windows $out/share/lutebot

    makeWrapper ${lib.getExe' protontricks "protontricks"} $out/bin/lutebot \
      --add-flags "-c 'wine $out/share/lutebot/LuteBot.exe' 629760"

    runHook postInstall
  '';

  meta = {
    description = "A companion program for LuteMod, a Mordhau mod to play music";
    homepage = "https://github.com/Dimencia/LuteBot3";
    sourceProvenance = [lib.sourceTypes.binaryBytecode];
    license = lib.licenses.mit;
  };
})
