{
  lib,
  stdenvNoCC,
  python3,
}:
stdenvNoCC.mkDerivation {
  name = "header-gen";

  src = ./header-gen;

  phases = ["installPhase"];
  installPhase = ''
    install -Dm755 $src $out/bin/header-gen
    substituteInPlace $out/bin/header-gen \
      --replace-fail "#!/usr/bin/env python3" "#!${lib.getExe python3}"
  '';

  meta = {
    description = "A very simple two-lines header generator";
    homepage = "https://codeberg.org/PierreBorine/nix-packages";
    license = lib.licenses.mit;
  };
}
