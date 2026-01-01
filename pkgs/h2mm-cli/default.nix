{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeWrapper,
  bash,
  gnused,
  gnugrep,
  gawk,
  findutils,
  coreutils,
  curlMinimal,
  unzip,
  unar,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "h2mm-cli";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "v4n00";
    repo = "h2mm-cli";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-MwARc/gR5BAjLh+Xw62TADo/QL1l+SYgZfbXeSYIqG4=";
  };

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin
    cp h2mm $out/bin

    wrapProgram $out/bin/h2mm \
      --set PATH ${lib.makeBinPath [
      bash
      gnused
      gnugrep
      gawk
      findutils
      coreutils
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
})
