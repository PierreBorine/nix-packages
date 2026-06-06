{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "svg-to-ico";
  version = "1.3.1";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "Ortham";
    repo = "svg_to_ico";
    tag = finalAttrs.version;
    hash = "sha256-jwSSXf1b6GdXbcKy4SsFLJIPgcgFlHlv29JR1437j/Q=";
  };

  cargoHash = "sha256-zNHpEyISPn3SGBK0LFmkfYgnzziiXG5D+gKRHHdKwCI=";

  nativeBuildInputs = [versionCheckHook];

  passthru.updateScript = nix-update-script {extraArgs = ["--flake"];};

  meta = {
    description = "A utility and Rust library to convert SVG icons into Windows ICO files";
    homepage = "https://github.com/Ortham/svg_to_ico";
    changelog = "https://github.com/Ortham/svg_to_ico/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "svg_to_ico";
  };
})
