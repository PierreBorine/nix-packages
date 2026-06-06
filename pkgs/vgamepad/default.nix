{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  libevdev,
  evdev,
}:
buildPythonPackage rec {
  pname = "vgamepad";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "yannbouteiller";
    repo = "vgamepad";
    rev = "v${version}";
    hash = "sha256-3nCErxmY66ApfF1aPmTnOGOYv8QHMcnOBvVx0+FcID4=";
  };

  build-system = [setuptools];

  buildInputs = [libevdev evdev];

  pythonImportsCheck = ["vgamepad"];

  meta = {
    description = "Virtual XBox360 and DualShock4 gamepads in python";
    homepage = "https://github.com/yannbouteiller/vgamepad";
    changelog = "https://github.com/gvalkov/python-evdev/blob/v${version}/docs/changelog.rst";
    license = lib.licenses.mit;
    maintainers = [];
    platforms = lib.platforms.linux;
  };
}
