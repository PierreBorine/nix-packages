{
  writeShellScript,
  stdenvNoCC,
  fetchurl,
  protontricks,
  makeDesktopItem,
  copyDesktopItems,
}: let
  name = "frankensteiner";
  version = "1.4.1.0";

  frankensteinerExe = fetchurl {
    url = "https://github.com/Dealman/Frankensteiner/releases/download/${version}/Frankensteiner.exe";
    hash = "sha256-mU5aN2mfXGaGmDfbtG4DLmbIU1kPIyiXaSYwvHSuNhM=";
  };

  script = writeShellScript name ''
    ${protontricks}/bin/protontricks -c "wine ${frankensteinerExe}" 629760
  '';
in
  stdenvNoCC.mkDerivation {
    pname = name;
    inherit version;

    src = script;

    nativeBuildInputs = [copyDesktopItems];

    desktopItems = [
      (makeDesktopItem {
        name = "Frankensteiner";
        desktopName = "Frankensteiner";
        genericName = "Mordhau loadout face editor";
        exec = name;
        icon = "mordhau";
        terminal = false;
        categories = ["Application" "Game" "Utility"];
      })
    ];

    phases = ["installPhase"];
    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp $src $out/bin/${name}

      mkdir -p $out/share/icons/hicolor
      cp -r ${./icons}/* $out/share/icons/hicolor

      runHook postInstall
    '';
  }
