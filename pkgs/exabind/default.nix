{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, bzip2
, zstd
}:
rustPlatform.buildRustPackage {
  pname = "exabind";
  version = "unstable-2024-11-24";

  src = fetchFromGitHub {
    owner = "junkdog";
    repo = "exabind";
    rev = "66ecaac1cc1e6cb3ff0411a49d364183630e430c";
    hash = "sha256-/FGMnTAv4CqL/jcLxRA9EaXhE9st5VHk+iLGm1LSPHQ=";
  };

  cargoHash = "sha256-hMa67WcqqZAcN11LqXIoAP/Pjse8QjEuw2+6aJhz8xY=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    bzip2
    zstd
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  patchPhase = ''
    # Fix build issue
    sed -i '1i use crossterm::event::ModifierKeyCode;' src/parser/kde.rs
    # Add support for Enter
    sed -i "/\/\/ Navigation keys/a \"Enter\" => Enter," src/parser/kde.rs
  '';

  meta = {
    description = "";
    homepage = "https://github.com/junkdog/exabind";
    license = lib.licenses.mit;
    mainProgram = "exabind";
  };
}
