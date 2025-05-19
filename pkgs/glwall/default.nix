{
  stdenv,
  lib,
  fetchFromGitHub,
  stb,
  glfw,
  glew,
}:
# Waiting for https://github.com/NixOS/nixpkgs/pull/191826
stdenv.mkDerivation rec {
  name = "GLWall";
  version = "24c80a291858557611d6ccdfef7cb41dfe9afe46";

  src = fetchFromGitHub {
    owner = "ikz87";
    repo = "GLWall";
    rev = version;
    sha256 = "sha256-7vXV019UeicN9DPKYCaQpN6D6v5Cd27KY5YZwS5FOIA=";
  };

  nativeBuildInputs = [
    stb
    glfw
    glew
  ];

  buildPhase = ''
    gcc main.c -o ${name} -lm -I${stb}/include/stb -lglfw -lGL -lGLEW
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r ${name} $out/bin/${name}
  '';

  meta = with lib; {
    description = "GLSL renderer meant to be used for live and responsive wallpapers";
    homepage = "https://github.com/ikz87/GLWall";
    platforms = platforms.linux;
    mainProgram = name;
  };
}
