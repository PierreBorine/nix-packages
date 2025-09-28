{
  stdenvNoCC,
  fetchurl,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "asciid";
  version = "0.1.0";

  src = fetchurl {
    # https://fonts.cdnfonts.com/s/73099/asciid.[fontvir.us].ttf
    url = "https://fonts.cdnfonts.com/s/73099/asciid.%5Bfontvir.us%5D.ttf";
    hash = "sha256-ub/2Uhyx7l3ox5CtKwgyE4bSrsRSTstm8czgO57Fqtc=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm444 $src $out/share/fonts/TrueType/asciid.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.cdnfonts.com/asciid.font";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
