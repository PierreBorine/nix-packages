{
  lib,
  stdenv,
  makeWrapper,
  coreutils,
  wl-clipboard,
  php,
  ncurses,
  inputs,
}:
# Waiting for https://github.com/NixOS/nixpkgs/pull/191826
stdenv.mkDerivation {
  name = "h-m-m";
  version = inputs.h-m-m.rev;

  src = inputs.h-m-m;

  nativeBuildInputs = [makeWrapper];

  # Remove a bashism, so it can be run with shells like Dash
  patchPhase = ''
    sed -i 's/command -v xclip xsel wl-copy klipper/command -v xclip || command -v xsel || command -v wl-copy || command -v klipper/g' h-m-m
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r h-m-m $out/bin/h-m-m
  '';

  postFixup = ''
    wrapProgram $out/bin/h-m-m \
      --set PATH ${lib.makeBinPath [
      php
      ncurses
      coreutils
      wl-clipboard
    ]}
  '';

  meta = with lib; {
    description = "A simple, fast, keyboard-centric terminal-based tool for working with mind maps";
    homepage = "https://github.com/nadrad/h-m-m";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
