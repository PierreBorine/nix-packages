{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  cmake,
  setuptools-scm,
  libX11,
  libXcursor,
  libXi,
  libXinerama,
  libXrandr,
  libglvnd,
  libxcrypt,
  pillow,
  wheel,
}:
buildPythonPackage (finalAttrs: {
  pname = "dearpygui";
  version = "2.3.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "hoffstadt";
    repo = "DearPyGui";
    rev = "v${finalAttrs.version}";
    hash = "sha256-R0YndwH8jqfaw6ABYSX8ZLy1DNLPAC4/Ti2iBt/SycM=";
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

  buildInputs = [
    libX11
    libXcursor
    libXi
    libXinerama
    libXrandr
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

  passthru.updateScript = nix-update-script {extraArgs = ["--flake"];};

  meta = {
    description = "Dear PyGui: A fast and powerful Graphical User Interface Toolkit for Python with minimal dependencies";
    homepage = "https://github.com/hoffstadt/DearPyGui";
    license = lib.licenses.mit;
  };
})
