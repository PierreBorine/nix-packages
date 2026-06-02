{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchzip,
  copyDesktopItems,
  makeDesktopItem,
  cmake,
  tomlplusplus,
  boost190,
  onetbb,
  spdlog,
  zlib,
  fmt,
  icu,
  qt6,
  ogdf,
  libGL,
  vulkan-headers,
  libx11,
  svg-to-ico,
  libloot-cpp,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "loot";
  version = "0.29.1";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "loot";
    repo = "loot";
    tag = finalAttrs.version;
    hash = "sha256-iloezojKVhxwnuMv9XDIdW3Xnb693YEnH0dwdmYlXkE=";
  };

  desktopItems = [
    (makeDesktopItem {
      name = "LOOT";
      desktopName = "LOOT";
      genericName = "Mod utility for Bethesda Games such as Skyrim";
      exec = "LOOT";
      icon = "loot";
      terminal = false;
      categories = ["Application" "Game" "Utility"];
    })
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBoost_USE_STATIC_LIBS=OFF"

    "-DFETCHCONTENT_SOURCE_DIR_MINIZIP=${finalAttrs.passthru.minizip-src}"
    "-DFETCHCONTENT_SOURCE_DIR_VALVEFILEVDF=${finalAttrs.passthru.ValveFileVDF-src}"

    "-DLOOT_BUILD_TESTS=OFF"
  ];

  nativeBuildInputs = [
    copyDesktopItems
    cmake

    svg-to-ico

    vulkan-headers
    qt6.qtbase
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    libloot-cpp
    zlib
    tomlplusplus
    fmt
    spdlog
    boost190
    icu
    onetbb
    ogdf
    libGL
    libx11
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp LOOT $out/bin
    install -Dm444 icon/icon.ico $out/share/pixmaps/loot.ico
    install -Dm444 ../resources/icons/loot.svg $out/share/icons/hicolor/scalable/apps/loot.svg

    runHook postInstall
  '';

  passthru = {
    minizip-src = fetchzip {
      url = "https://github.com/zlib-ng/minizip-ng/archive/refs/tags/4.1.0.tar.gz";
      hash = "sha256-H6ttsVBs437lWMBsq5baVDb9e5I6Fh+xggFre/hxGKU=";
    };

    ValveFileVDF-src = fetchzip {
      url = "https://github.com/TinyTinni/ValveFileVDF/archive/refs/tags/v1.1.1.tar.gz";
      hash = "sha256-s7wyHIcqMDHTSudIgy/bzZixQCL/T+ziFQxZh8w15uE=";
    };
  };

  meta = {
    description = "A modding utility for Starfield and some Elder Scrolls and Fallout games";
    homepage = "https://github.com/loot/loot";
    changelog = "https://github.com/loot/loot/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl3Only;
    mainProgram = "LOOT";
    platforms = lib.platforms.all;
  };
})
