{
  stdenv,
  lib,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
  autoconf,
  automake,
  fuse3,
  ffmpeg,
  pkg-config,
  gnused,
  sqlite,
  libcue,
  libchardet,
  libdvdread,
  libdvdnav,
  libbluray,
  asciidoc-full,
  chromaprint,
  w3m,
  xxd,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "ffmpegfs";
  version = "2.18";

  src = fetchFromGitHub {
    owner = "nschlia";
    repo = "ffmpegfs";
    rev = "v${finalAttrs.version}";
    hash = "sha256-kYMUnX7WcPvhkR6BB58SntedlU6PtRb6RcLSOVhJeKg=";
  };

  nativeBuildInputs = [
    versionCheckHook
    autoconf
    automake
    pkg-config
    asciidoc-full
    w3m
    gnused
    xxd
  ];

  buildInputs = [
    fuse3
    ffmpeg
    sqlite
    libcue
    libchardet
    # Not Required for building
    libdvdread
    libbluray
    chromaprint
    libdvdnav
  ];

  postPatch = ''
    ./autogen.sh
  '';

  passthru.updateScript = nix-update-script {extraArgs = ["--flake"];};

  meta = {
    description = "FUSE-based transcoding filesystem with video support from many formats to FLAC, MP4, TS, WebM, OGG, MP3, HLS, and others";
    homepage = "https://github.com/nschlia/ffmpegfs";
    changelog = "https://github.com/nschlia/ffmpegfs/blob/${finalAttrs.src.rev}/NEWS";
    license = with lib.licenses; [gpl3Only cc0];
    mainProgram = "ffmpegfs";
    platforms = lib.platforms.unix;
  };
})
