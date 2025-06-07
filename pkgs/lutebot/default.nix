{
  writeShellScript,
  stdenvNoCC,
  fetchzip,
  protontricks,
  makeDesktopItem,
  copyDesktopItems,
}: let
  name = "lutebot";
  version = "3.6.5";

  lutebotExe =
    (fetchzip {
      url = "https://github.com/Dimencia/LuteBot3/releases/download/v${version}/LuteBot.${version}.zip";
      hash = "sha256-u5PsqqVcpL+RiYn3eS0CU5l50lH1NKa0WKpkYajASy4=";
    })
    + "/bin/Release/net7.0-windows/LuteBot.exe";

  script = writeShellScript name ''
    ${protontricks}/bin/protontricks -c "wine ${lutebotExe}" 629760
  '';
in
  stdenvNoCC.mkDerivation {
    pname = name;
    inherit version;

    src = script;

    nativeBuildInputs = [copyDesktopItems];

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
      cp $src $out/bin/${name}

      mkdir -p $out/share/icons/hicolor
      cp -r ${./icons}/* $out/share/icons/hicolor

      runHook postInstall
    '';
  }
