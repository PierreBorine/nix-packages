{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
  cmake,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "libloot-cpp";
  version = "0.29.5";
  __structuredAttrs = true;
  enableParallelBuilding = true;

  outputs = [
    "out"
    "dev"
  ];

  src = fetchFromGitHub {
    owner = "loot";
    repo = "libloot";
    tag = finalAttrs.version;
    hash = "sha256-faqsT3Y8rxEyilZ5V1c3n/Q5ozyOqVa7IrNHRx3ZJi0=";
  };

  cargoHash = "sha256-i1Y+4d2ri9+mMpFNKUqHi+K4R6ScXqxPucywZeP+YKE=";

  nativeBuildInputs = [cmake];

  env.LIBLOOT_REVISION = finalAttrs.src.rev;

  buildPhase = ''
    runHook preBuild

    cd cpp
    cmake -B build . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLIBLOOT_BUILD_TESTS=OFF
    cmake --build build --parallel

    # HACK: there probably is a cleaner way
    substituteInPlace build/liblootTargets.cmake \
      --replace-fail '/build/source/cpp/build' "$out/lib" \
      --replace-fail '/build/source/cpp/include' "$dev/include"

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib $dev/lib/cmake/libloot

    cp -r include $dev
    cp build/liblootConfig.cmake \
      build/liblootConfigVersion.cmake \
      build/liblootTargets.cmake \
      $dev/lib/cmake/libloot
    cp build/libloot.so* $out/lib

    runHook postInstall
  '';

  doCheck = false;

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "A library for accessing LOOT's metadata and sorting functionality";
    homepage = "https://github.com/loot/libloot";
    changelog = "https://github.com/loot/libloot/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl3Only;
  };
})
