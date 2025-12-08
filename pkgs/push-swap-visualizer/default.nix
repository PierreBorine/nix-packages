{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchurl,
  cmake,
  imgui,
  sfml_2,
  git,
}: let
  sfml-content = fetchurl {
    url = "https://github.com/SFML/SFML/releases/download/2.5.1/SFML-2.5.1-sources.zip";
    hash = "sha256-vx4GQ6y5I2myRXK3A0c69gusgsr1r2HnfAY7d5Rxu38=";
  };
  imgui-content = fetchFromGitHub {
    owner = "ocornut";
    repo = "imgui";
    rev = "35b1148efb839381b84de9290d9caf0b66ad7d03";
    hash = "sha256-IFz2HYaxXR1so9kpJ7SAmOFek2jOxJ9T51M4KjTqdCg=";
  };
  imgui-sfml-content = fetchFromGitHub {
    owner = "eliasdaler";
    repo = "imgui-sfml";
    rev = "82dc2033e51b8323857c3ae1cf1f458b3a933c35";
    hash = "sha256-jvQ9bsZxGen+fxk3jogDX27V3WVLWWOTur1vWcTomrY=";
  };
  catch2-content = fetchFromGitHub {
    owner = "catchorg";
    repo = "Catch2";
    rev = "v2.13.7";
    hash = "sha256-NhZ8Hh7dka7KggEKKZyEbIZahuuTYeCT7cYYSUvkPzI=";
  };
in
  stdenv.mkDerivation {
    pname = "push-swap-visualizer";
    version = "1.5";

    # Fork from `o-reo`'s repo that fixes a compile error
    src = fetchFromGitHub {
      owner = "jotuel";
      repo = "push_swap_visualizer";
      rev = "4ad3952b65f12009bed407cba65dcf79d17506cf";
      hash = "sha256-U0Z2JTASvYIo1lRyLcJhHQzu2SAPvsTP8isGSdVKefA=";
    };

    nativeBuildInputs = [
      cmake
      git
    ];

    buildInputs = [
      imgui
      sfml_2
    ];

    cmakeFlags = [
      "-DFETCHCONTENT_SOURCE_DIR_SFML=${sfml-content}"
      "-DFETCHCONTENT_SOURCE_DIR_IMGUI=${imgui-content}"
      "-DFETCHCONTENT_SOURCE_DIR_IMGUI-SFML=${imgui-sfml-content}"
      "-DFETCHCONTENT_SOURCE_DIR_CATCH2=${catch2-content}"
      "-DCMAKE_POLICY_VERSION_MINIMUM=3.10"
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp bin/visualizer $out/bin/visualizer

      runHook postInstall
    '';

    meta = {
      description = "A clean visualizer for your Push Swap Algorithm, you can't fix what you can't see";
      homepage = "https://github.com/o-reo/push_swap_visualizer";
      license = lib.licenses.gpl3Only;
      mainProgram = "visualizer";
      platforms = lib.platforms.all;
    };
  }
