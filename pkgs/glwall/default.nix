{
  inputs,
  stdenv,
  lib,
  stb,
  glfw,
  glew,
}:
# Waiting for https://github.com/NixOS/nixpkgs/pull/191826
stdenv.mkDerivation rec {
  name = "GLWall";
  version = inputs.GLWall.rev;

  src = inputs.GLWall;

  nativeBuildInputs = [
    stb
    glfw
    glew
  ];

  patchPhase = ''
    sed -i "s|/usr/include/stb|${toString stb}/include/stb|" Makefile
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r ${name} $out/bin/${name}
  '';

  meta = with lib; {
    description = "GLSL fragment shader renderer meant to be used for live and responsive wallpapers";
    homepage = "https://github.com/ikz87/GLWall";
    platforms = platforms.linux;
    mainProgram = name;
  };
}
