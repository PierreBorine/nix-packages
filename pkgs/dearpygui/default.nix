{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  cmake,
  setuptools-scm,
  xorg,
  libglvnd,
  libxcrypt,
  pillow,
  wheel,
}:
buildPythonPackage (finalAttrs: {
  pname = "dearpygui";
  version = "2.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "hoffstadt";
    repo = "DearPyGui";
    rev = "v${finalAttrs.version}";
    hash = "sha256-YkLco717xgNwzje53/xa/p1EJI3YO9E54Xkee8OXU2w=";
    fetchSubmodules = true;
  };

  dontUseCmakeConfigure = true;
  nativeBuildInputs = [
    cmake
    setuptools-scm
  ];

  preBuild = ''
    export MAKEFLAGS="''${MAKEFLAGS:+''${MAKEFLAGS} }-j$NIX_BUILD_CORES"
  '';

  buildInputs = with xorg;
    [
      libX11
      libXcursor
      libXi
      libXinerama
      libXrandr
    ]
    ++ [
      libglvnd
      libxcrypt
      wheel
    ];

  propagatedBuildInputs = [pillow];
  doCheck = false;

  pythonImportsCheck = [
    "dearpygui"
    "dearpygui.dearpygui"
  ];

  meta = {
    description = "Dear PyGui: A fast and powerful Graphical User Interface Toolkit for Python with minimal dependencies";
    homepage = "https://github.com/hoffstadt/DearPyGui";
    license = lib.licenses.mit;
  };
})
