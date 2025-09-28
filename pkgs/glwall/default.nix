{
  fetchFromGitHub,
  stdenv,
  lib,
  stb,
  glfw,
  glew,
}:
stdenv.mkDerivation {
  name = "GLWall";
  version = "unstable-2025-05-29";

  src = fetchFromGitHub {
    owner = "ikz87";
    repo = "GLWall";
    rev = "207283ad1f466f1f6df8b7d6e6f55bcb19607216";
    hash = "sha256-NasKu7QbNq7vjDnhAeJWYlcI0n13hne4pUV1MomDcdk=";
  };

  nativeBuildInputs = [
    stb
    glfw
    glew
  ];

  patchPhase = ''
    sed -i "s|/usr/include/stb|${stb}/include/stb|" Makefile
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r GLWall $out/bin/GLWall
  '';

  meta = {
    description = "GLSL fragment shader renderer meant to be used for live and responsive wallpapers";
    homepage = "https://github.com/ikz87/GLWall";
    platforms = lib.platforms.linux;
    mainProgram = "GLWall";
  };
}
