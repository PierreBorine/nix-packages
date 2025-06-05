{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  dearpygui,
  pyinstaller,
  tkinter,
  colorama,
  pyyaml,
  requests,
  pyperclip,
  makeDesktopItem,
  copyDesktopItems,
}:
stdenvNoCC.mkDerivation rec {
  pname = "barotrauma-modding-tool";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "themanyfaceddemon";
    repo = "Barotrauma_Modding_Tool";
    rev = version;
    hash = "sha256-6vPfNC3q3QUWiauxg0HmfNBRiIo35+wVgL3kkqyID40=";
  };

  desktopItems = [
    (makeDesktopItem {
      name = "Barotrauma Modding Tool";
      desktopName = "Barotrauma Modding Tool";
      genericName = "Mod utility for Barotrauma";
      exec = pname;
      icon = "barotrauma";
      terminal = false;
      categories = ["Application" "Game" "Utility"];
    })
  ];

  nativeBuildInputs = [
    copyDesktopItems
    pyinstaller
  ];

  buildInputs = [
    tkinter
    colorama
    dearpygui
    pyyaml
    requests
    pyperclip
  ];

  buildPhase = ''
    pyinstaller main.py --add-data=Data:Data
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 dist/main/main $out/bin/${pname}
    cp -r dist/main/_internal $out/bin

    mkdir -p $out/share/icons/hicolor
    cp -r ${./icons}/* $out/share/icons/hicolor

    runHook postInstall
  '';

  meta = {
    description = "Barotrauma mod loader tool";
    homepage = "https://github.com/themanyfaceddemon/Barotrauma_Modding_Tool";
    license = lib.licenses.gpl3Only;
    mainProgram = pname;
    platforms = lib.platforms.all;
  };
}
