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

  nativeBuildInputs = [pyinstaller];

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
