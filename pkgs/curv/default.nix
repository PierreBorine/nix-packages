{
  lib,
  fetchFromGitHub,
  buildPythonApplication,
  nix-update-script,
  hatchling,
  pyperclip,
  readchar,
  rich,
}:
buildPythonApplication (finalAttrs: {
  pname = "curv";
  version = "0-unstable-2026-05-11";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "programmersd21";
    repo = "curv";
    rev = "04a49ba27d7a4eb4c7a31e1a6b6c4a6e2babee13";
    hash = "sha256-/KR5Zxwve/UKvEVQF/FjVdpUC2aYW4YljuQ53uMtC50=";
  };

  build-system = [hatchling];

  dependencies = [
    pyperclip
    readchar
    rich
  ];

  pythonImportsCheck = ["curv"];

  passthru.updateScript = nix-update-script {
    extraArgs = ["--flake" "--version=branch"];
  };

  meta = {
    description = "Bezier curves lab for your terminal";
    homepage = "https://github.com/programmersd21/curv";
    changelog = "https://github.com/programmersd21/curv/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "curv";
  };
})
