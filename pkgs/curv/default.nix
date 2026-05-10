{
  lib,
  fetchFromGitHub,
  buildPythonApplication,
  hatchling,
  pyperclip,
  readchar,
  rich,
}:
buildPythonApplication (finalAttrs: {
  pname = "curv";
  version = "0-unstable-2026-05-10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "programmersd21";
    repo = "curv";
    rev = "a12aae56173261084040fe62fac7c7112907582b";
    hash = "sha256-oMV6zfRwwH3TDv4Vyx3up+MXOaUNk/h8NaFibmIZ788=";
  };

  build-system = [hatchling];

  dependencies = [
    pyperclip
    readchar
    rich
  ];

  pythonImportsCheck = ["curv"];

  meta = {
    description = "Bezier curves lab for your terminal";
    homepage = "https://github.com/programmersd21/curv";
    changelog = "https://github.com/programmersd21/curv/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "curv";
  };
})
