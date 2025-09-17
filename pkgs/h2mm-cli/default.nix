{
  lib,
  stdenvNoCC,
  inputs,
  makeWrapper,
  bash,
  gnused,
  gnugrep,
  gawk,
  uutils-findutils,
  uutils-coreutils-noprefix,
  curlMinimal,
  unzip,
  unar,
}: let
  inherit (lib.strings) removeSuffix makeBinPath;
  inherit (builtins) readFile;
in
  stdenvNoCC.mkDerivation rec {
    pname = "h2mm-cli";
    version = removeSuffix "\n" (readFile "${src}/version");

    src = inputs.h2mm;

    nativeBuildInputs = [makeWrapper];

    installPhase = ''
      mkdir -p $out/bin
      cp h2mm $out/bin

      wrapProgram $out/bin/h2mm \
        --set PATH ${makeBinPath [
        bash
        gnused
        gnugrep
        gawk
        uutils-findutils
        uutils-coreutils-noprefix
        curlMinimal
        unzip
        unar
      ]}
    '';

    meta = {
      description = "Helldivers 2 Mod Manager CLI for Linux";
      homepage = "https://github.com/v4n00/h2mm-cli";
      mainProgram = "h2mm";
      platforms = lib.platforms.linux;
    };
  }
