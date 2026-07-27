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
  version = "0-unstable-2026-06-11";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "programmersd21";
    repo = "curv";
    rev = "4dd0dfbc583a250475f374c8d3b98864908e8bf2";
    hash = "sha256-zrZlehBGMB/4NMsJsMBWgb56RO0B1tngoz0I4FhfaRM=";
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
