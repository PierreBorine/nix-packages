{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  libevdev,
  evdev,
}:
buildPythonPackage rec {
  pname = "vgamepad";
  version = "0.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-V/a9Aa7AwXKUdRf7eC0VDvmyhff01STDFzdPpcJKid4=";
  };

  build-system = [setuptools];

  buildInputs = [
    libevdev
    evdev
  ];

  doCheck = false;

  pythonImportsCheck = ["vgamepad"];

  meta = with lib; {
    description = "Virtual XBox360 and DualShock4 gamepads in python";
    homepage = "https://github.com/yannbouteiller/vgamepad";
    changelog = "https://github.com/gvalkov/python-evdev/blob/v${version}/docs/changelog.rst";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.linux;
  };
}
