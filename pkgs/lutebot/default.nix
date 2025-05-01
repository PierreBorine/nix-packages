{
  writeShellScript,
  stdenvNoCC,
  fetchzip,
  protontricks,
  makeDesktopItem,
  copyDesktopItems,
  imagemagick,
}: let
  lutebotExe =
    (fetchzip {
      url = "https://github.com/Dimencia/LuteBot3/releases/download/v3.6.5/LuteBot.3.6.5.zip";
      hash = "sha256-u5PsqqVcpL+RiYn3eS0CU5l50lH1NKa0WKpkYajASy4=";
    })
    + "/bin/Release/net7.0-windows/LuteBot.exe";

  name = "lutebot";
  script = writeShellScript name ''
    ${protontricks}/bin/protontricks -c "wine ${lutebotExe}" 629760
  '';
in
  stdenvNoCC.mkDerivation {
    inherit name;

    src = ./mordhau.png;

    nativeBuildInputs = [copyDesktopItems imagemagick];

    desktopItems = [
      (makeDesktopItem {
        name = "LuteBot";
        desktopName = "LuteBot";
        genericName = "Mordhau Music Tool";
        exec = name;
        icon = "mordhau";
        terminal = false;
        categories = ["Application" "Game" "Utility" "Audio"];
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
