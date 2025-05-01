{
  writeShellScript,
  stdenvNoCC,
  fetchurl,
  protontricks,
  makeDesktopItem,
  copyDesktopItems,
  imagemagick,
}: let
  frankensteinerExe = fetchurl {
    url = "https://github.com/Dealman/Frankensteiner/releases/download/1.4.1.0/Frankensteiner.exe";
    hash = "sha256-mU5aN2mfXGaGmDfbtG4DLmbIU1kPIyiXaSYwvHSuNhM=";
  };

  name = "frankensteiner";
  script = writeShellScript name ''
    ${protontricks}/bin/protontricks -c "wine ${frankensteinerExe}" 629760
  '';
in
  stdenvNoCC.mkDerivation rec {
    name = "frankensteiner";

    src = ./mordhau.png;

    nativeBuildInputs = [copyDesktopItems imagemagick];

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
      cp ${script} $out/bin/${name}

      runHook postInstall
    '';

    postInstall = ''
      for i in 16 24 48 64 96 128; do
        mkdir -p $out/share/icons/hicolor/''${i}x''${i}/apps
        convert -background none -resize ''${i}x''${i} $src $out/share/icons/hicolor/''${i}x''${i}/apps/mordhau.png
      done
    '';
  }
