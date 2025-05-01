{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "dusage";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "mihaigalos";
    repo = "dusage";
    rev = version;
    hash = "sha256-8nMx/HvsZCN4npKBj/iGn+mlx5g4MLfv314uyViIqUQ=";
  };

  cargoHash = "sha256-PCB+DpRMZU2z0EuGqJ1kT8hqd/EmIbSp1vYYDBKX9vo=";

  meta = {
    description = "A command line disk usage information tool";
    homepage = "https://github.com/mihaigalos/dusage?ref=terminaltrove";
    license = lib.licenses.mit;
    mainProgram = "dusage";
  };
}
