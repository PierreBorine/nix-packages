# This is a wallpaper picker for the awww daemon
#
# The qml and bash code here is a heavily striped-down version of ilyamiro's
# QuickShell config to only keep the wallpaper picker.
# author: https://github.com/ilyamiro
# source: https://github.com/ilyamiro/nixos-configuration
{
  lib,
  stdenvNoCC,
  makeWrapper,
  ffmpegthumbnailer,
  quickshell,
  # customize the wayland layer namespace
  namespace ? "qs-wallpaper-picker",
}:
stdenvNoCC.mkDerivation {
  pname = "wallpaper-picker";
  version = "0.1.0";

  src = ./src;

  nativeBuildInputs = [makeWrapper];

  phases = ["unpackPhase" "installPhase"];

  installPhase = ''
    mkdir -p $out/share/wallpaper-picker $out/bin

    cp * $out/share/wallpaper-picker

    substituteInPlace shell.qml \
      --replace 'qs-wallpaper-picker' '${namespace}'

    makeWrapper $out/share/wallpaper-picker/run.sh $out/bin/picker \
      --prefix PATH : ${lib.makeBinPath [ffmpegthumbnailer quickshell]}
  '';

  meta = {
    mainProgram = "picker";
    maintainers = [lib.maintainers.pierreborine];
  };
}
