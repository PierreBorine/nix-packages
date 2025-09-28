{
  inputs,
  lib,
  makeRustPlatform,
  fetchFromGitHub,
  stdenv,
  makeWrapper,
  pkg-config,
  dbus,
  libusb1,
  withSysinfo ? true,
  withHotkeys ? false, # X11 only
  # https://github.com/not-jan/apex-tux/issues/69
  withImage ? false, # broken
  withSimulator ? false, # broken
  withDbus ? true,
}: let
  buildNightlyRustPackage =
    (makeRustPlatform {
      inherit (inputs.fenix.packages.${stdenv.system}.minimal) cargo rustc;
    }).buildRustPackage;
in
  buildNightlyRustPackage (finalAttrs: {
    pname = "apex-tux";
    version = "unstable-2025-08-03";

    src = fetchFromGitHub {
      owner = "not-jan";
      repo = "apex-tux";
      rev = "6d334182f54ef8822e1b50f964161b615927112e";
      hash = "sha256-2mWNFwn4xo3dklXvwT+w6m8svGY5/WjiYwktqm43YQs=";
    };

    cargoLock = {
      lockFile = ./Cargo.lock;
      outputHashes = {
        "gamesense-0.1.2" = "sha256-CeLP4r63cdjsCKaRsWNI3cvR7XSbVXSkK7OLCR5m03c=";
      };
    };

    buildFeatures =
      lib.optional withSysinfo "sysinfo"
      ++ lib.optional withHotkeys "hotkeys"
      ++ lib.optional withImage "image"
      ++ lib.optional withSimulator "simulator"
      ++ lib.optional (!withDbus) "usb";

    cargoBuildFlags =
      lib.optionalString (!withDbus) "--no-default-features";

    nativeBuildInputs = [
      pkg-config
      makeWrapper
    ];

    buildInputs = [
      libusb1
      dbus
    ];

    postPatch = ''
      ln -s ${./Cargo.lock} Cargo.lock
    '';

    env.LD_LIBRARY_PATH = lib.makeLibraryPath finalAttrs.buildInputs;

    postFixup = ''
      wrapProgram $out/bin/apex-tux \
        --prefix LD_LIBRARY_PATH : ${finalAttrs.env.LD_LIBRARY_PATH}
    '';

    meta = {
      description = "Linux support for the OLED screen of the Apex Pro, Apex 5 and Apex 7 keyboards by SteelSeries";
      homepage = "https://github.com/not-jan/apex-tux";
      license = lib.licenses.unlicense;
      mainProgram = "apex-tux";
    };
  })
