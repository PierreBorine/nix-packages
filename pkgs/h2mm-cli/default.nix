{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
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
}:
stdenvNoCC.mkDerivation rec {
  pname = "h2mm-cli";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "v4n00";
    repo = "h2mm-cli";
    rev = "v${version}";
    hash = "sha256-vGPhRJEKhpcW6THv4e/D1LRXQSmAOcCCmZ44D/Miy98=";
  };

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin
    cp h2mm $out/bin
  '';

  postFixup = ''
    wrapProgram $out/bin/h2mm \
      --set PATH ${lib.makeBinPath [
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
    platforms = lib.platforms.all;
  };
}
