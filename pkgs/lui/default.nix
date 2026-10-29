{
  lib,
  stdenv,
  fetchFromGitea,
  zig,
  nix-update-script,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "lui";
  version = "0-unstable-2026-10-22";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "lukeflo";
    repo = "lui";
    rev = "73486a5b3911d5590a15655bc810067252f0f6b1";
    hash = "sha256-PzlJPHYaWGnESAL7jMAeZRLYTsV1JK+rwMhjO9rsiEc=";
  };

  nativeBuildInputs = [zig];

  zigDeps = zig.fetchDeps {
    inherit (finalAttrs) src pname version;
    fetchAll = true;
    hash = "sha256-k02Z2z+xexubEEU1n1h1ax/CTMId/CP4PCSKM+jl1D4=";
  };

  postConfigure = ''
    ln -s ${finalAttrs.zigDeps} "$ZIG_GLOBAL_CACHE_DIR/p"
  '';

  zigBuildFlags = ["-Doptimize=ReleaseFast"];

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "A TUI filemanager for `ls -lah --group-directories-first` in Zig";
    homepage = "https://codeberg.org/lukeflo/lui";
    license = lib.licenses.gpl3Only;
    maintainers = [lib.maintainers.pierreborine];
    mainProgram = "lui";
    inherit (zig.meta) platforms;
  };
})
