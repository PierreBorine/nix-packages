{
  cmake,
  fetchFromGitLab,
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

  src = fetchFromGitLab {
    domain = "opencode.net";
    owner = "ilya-fedin";
    repo = "qt6ct";
    rev = "b8d0b8f1489abdcfcb1ddcb775d020a88e9abd45"; # shenanigans branch
    hash = "sha256-i7rm9kShaVIf6ChFngexCDKjX02htDrtHCcNCxPslRE=";
  };

  nativeBuildInputs = [
    cmake
    qttools
    wrapQtAppsHook
  ];

  buildInputs = [
    qtbase
    qtsvg
    qtwayland

    kconfig
    kcolorscheme
    qtdeclarative
    kiconthemes
    qqc2-desktop-style
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
