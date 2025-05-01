{
  lib,
  stdenv,
}: {
  buildYaziPlugin = {
    name ? "yaziPlugin-${attrs.pname}-${attrs.version}",
    src,
    unpackPhase ? "",
    configurePhase ? ":",
    buildPhase ? ":",
    preInstall ? "",
    postInstall ? "",
    meta ? {},
    ...
  } @ attrs:
    stdenv.mkDerivation (attrs
      // {
        inherit name src unpackPhase configurePhase buildPhase preInstall postInstall;

        installPhase = ''
          mkdir -p $out
          cp $src/*.lua $out
        '';

        meta =
          {
            platforms = lib.platforms.all;
          }
          // meta;
      });
}
