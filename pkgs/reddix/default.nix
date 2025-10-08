{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  sqlite,
}:
rustPlatform.buildRustPackage rec {
  pname = "reddix";
  version = "0.1.14";

  src = fetchFromGitHub {
    owner = "ck-zhang";
    repo = "reddix";
    rev = "v${version}";
    hash = "sha256-t6+0t1sd8BLwXRiGyvIgb+cERmBV0SLkWqKj770PklE=";
  };

  cargoHash = "sha256-OuMohhHYQrxH1Dt4FuoG/6LuU6Mh17693ye882ffV7s=";

  nativeBuildInputs = [pkg-config];

  buildInputs = [sqlite];

  meta = {
    description = "Reddit, refined for the terminal";
    homepage = "https://github.com/ck-zhang/reddix";
    changelog = "https://github.com/ck-zhang/reddix/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "reddix";
  };
}
