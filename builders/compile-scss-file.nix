pkgs: name: src:
pkgs.stdenvNoCC.mkDerivation {
  inherit name src;

  passAsFile = ["text"];
  nativeBuildInputs = [pkgs.dart-sass];
  phases = ["buildPhase" "installPhase"];

  buildPhase = ''
    sass --no-source-map $src:${name}
  '';

  installPhase = ''
    cp ${name} $out
  '';
}
