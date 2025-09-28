{
  cmake,
  fetchFromGitHub,
  lib,
  qtbase,
  qtsvg,
  qttools,
  qtwayland,
  stdenv,
  wrapQtAppsHook,
  kconfig,
  kcolorscheme,
  qtdeclarative,
  kiconthemes,
  qqc2-desktop-style,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "qt6ct-kde";
  version = "0.10";

  src = fetchFromGitHub {
    owner = "ilya-fedin";
    repo = "qt6ct";
    rev = finalAttrs.version;
    hash = "sha256-ePY+BEpEcAq11+pUMjQ4XG358x3bXFQWwI1UAi+KmLo=";
  };

  nativeBuildInputs = [
    cmake
    qttools
    wrapQtAppsHook
    kconfig
    kcolorscheme
    qtdeclarative
    kiconthemes
    qqc2-desktop-style
  ];

  buildInputs = [
    qtbase
    qtsvg
    qtwayland
  ];

  cmakeFlags = [
    "-DPLUGINDIR=${placeholder "out"}/${qtbase.qtPluginPrefix}"
  ];

  meta = {
    description = "Qt6 Configuration Tool";
    homepage = "https://github.com/ilya-fedin/qt6ct";
    changelog = "https://github.com/ilya-fedin/qt6ct/blob/${finalAttrs.src.rev}/ChangeLog";
    license = lib.licenses.bsd2;
    mainProgram = "qt6ct";
    platforms = lib.platforms.all;
  };
})
