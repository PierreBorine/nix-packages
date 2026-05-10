{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "binbreak";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "epic-64";
    repo = "binbreak";
    rev = "v${finalAttrs.version}";
    hash = "sha256-htCaPZZxfiSnoNgs+aLe6Kz8FDipG4eqwrfTfseBbxg=";
  };

  cargoHash = "sha256-qjzTOtUsPi44un8Vv/pUkm+bBGDey59vTgKYQM7mTcg=";

  meta = {
    description = "Terminal based binary number guessing game";
    homepage = "https://github.com/epic-64/binbreak";
    license = lib.licenses.mit;
    mainProgram = "binbreak";
  };
})
