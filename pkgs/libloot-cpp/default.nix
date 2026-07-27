{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
  cmake,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "libloot-cpp";
  version = "0.29.6";
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
    hash = "sha256-Pz13z0uQfTeo47NJORfZ8n8ucqZdoLVGNIsrf2+OOGA=";
  };

  cargoHash = "sha256-IQowGdrol/JFoh+hGfhwoJ2FumkvbuZsp8Xx/V2hFdw=";

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

  passthru.updateScript = nix-update-script {extraArgs = ["--flake"];};

  meta = {
    description = "A library for accessing LOOT's metadata and sorting functionality";
    homepage = "https://github.com/loot/libloot";
    changelog = "https://github.com/loot/libloot/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl3Only;
  };
})
