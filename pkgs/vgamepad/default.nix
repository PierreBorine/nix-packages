{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  setuptools,
  libevdev,
  evdev,
}:
buildPythonPackage (finalAttrs: {
  pname = "vgamepad";
  version = "0.1.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "yannbouteiller";
    repo = "vgamepad";
    rev = "v${finalAttrs.version}";
    hash = "sha256-VSik5dPBrGiQ9y7AwcVnt020NlAyIxZTIg3lbwNLZpk=";
  };

  build-system = [setuptools];

  buildInputs = [libevdev evdev];

  pythonImportsCheck = ["vgamepad"];

  passthru.updateScript = nix-update-script {extraArgs = ["--flake"];};

  meta = {
    description = "Virtual XBox360 and DualShock4 gamepads in python";
    homepage = "https://github.com/yannbouteiller/vgamepad";
    changelog = "https://github.com/gvalkov/python-evdev/blob/v${finalAttrs.version}/docs/changelog.rst";
    license = lib.licenses.mit;
    maintainers = [];
    platforms = lib.platforms.linux;
  };
})
