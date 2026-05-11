{
  lib,
  requireFile,
  appimageTools,
}: let
  pname = "hd2arsenal";
  version = "0.30.2-beta";

  # remove "-beta" types of suffix
  versionString =
    lib.versions.majorMinor version + "." + lib.versions.patch version;

  src = requireFile {
    name = "HD2Arsenal-${versionString}.AppImage";
    url = "https://www.nexusmods.com/helldivers2/mods/4664?tab=files";
    sha256 = "6139728c6e19d45f542814f5d3acf243d9947422f1887c6d2f04f380ceada31a";
  };

  appimageContents = appimageTools.extractType1 {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      mkdir -p $out/share/applications

      cp ${appimageContents}/hd2arsenal.desktop $out/share/applications
      install -Dm644 ${appimageContents}/hd2arsenal.png $out/share/icons/128x128/apps/hd2arsenal.png

      substituteInPlace $out/share/applications/hd2arsenal.desktop \
        --replace-fail 'Exec=AppRun --no-sandbox %U' "Exec=$out/bin/hd2arsenal"
    '';

    meta = {
      description = "Mod manager for Helldivers 2 that makes modding accessible and fun";
      homepage = "https://www.nexusmods.com/helldivers2/mods/4664";
      downloadPage = "https://www.nexusmods.com/helldivers2/mods/4664?tab=files";
      sourceProvenance = with lib.sourceTypes; [binaryBytecode];
      platforms = lib.platforms.linux;
      license = lib.licenses.unfree;
      mainProgram = "hd2arsenal";
    };
  }
