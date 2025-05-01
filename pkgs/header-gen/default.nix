{
  lib,
  stdenv,
  bash,
  makeWrapper,
}:
stdenv.mkDerivation {
  name = "header-gen";
  src = ./header-gen;
  buildInputs = [bash];
  nativeBuildInputs = [makeWrapper];
  phases = ["installPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/header-gen
    chmod +x $out/bin/header-gen
    wrapProgram $out/bin/header-gen \
      --prefix PATH : ${lib.makeBinPath [bash]}
  '';
}
