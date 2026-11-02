{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libarchive,
  openssl,
  zstd,
  nix-update-script,
  nxmUrlHandler ? true,
}:
rustPlatform.buildRustPackage {
  pname = "dmodman";
  version = "0-unstable-2026-09-03";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "dandels";
    repo = "dmodman";
    rev = "b6bcf5a5735c48ec79c000c62c4b20d5df4dcebf";
    hash = "sha256-7fo+jfzFnnDDbngIDcPhUBQlaZpo8RwzDlSZ7w0nwFM=";
  };

  cargoHash = "sha256-27hZpaZ8l3IJcPKwNEN0FmZUe6n7sefEemP7EYEl0fU=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    libarchive
    openssl
    zstd
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  postInstall = lib.optionalString nxmUrlHandler ''
    install -Dm 644 dmodman-terminal.desktop out/share/applications
  '';

  checkFlags = [
    # network tests, requiring CA certificates
    "--skip=api::nexus_api::download_link::tests"
    "--skip=api::update_checker::tests"
    "--skip=api::query::tests::block_test_request"
  ];

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "TUI downloader & update checker for Nexusmods.com";
    homepage = "https://github.com/dandels/dmodman";
    license = lib.licenses.mit;
    maintainers = [lib.maintainers.pierreborine];
    mainProgram = "dmodman";
  };
}
