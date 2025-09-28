{
  stdenv,
  lib,
  fetchFromGitHub,
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
  version = "2.17";

  src = fetchFromGitHub {
    owner = "nschlia";
    repo = "ffmpegfs";
    rev = "v${finalAttrs.version}";
    hash = "sha256-RXJXtHVMSZHy4dwzUkdJvf02NYv2tiIq9CA0H69Y0L4=";
  };

  nativeBuildInputs = [
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
    # Not Requierd for building
    libdvdread
    libbluray
    chromaprint
    libdvdnav
  ];

  postPatch = ''
    ./autogen.sh
  '';

  meta = {
    description = "FUSE-based transcoding filesystem with video support from many formats to FLAC, MP4, TS, WebM, OGG, MP3, HLS, and others";
    homepage = "https://github.com/nschlia/ffmpegfs";
    changelog = "https://github.com/nschlia/ffmpegfs/blob/${finalAttrs.src.rev}/NEWS";
    license = with lib.licenses; [gpl3Only cc0];
    mainProgram = "ffmpegfs";
    platforms = lib.platforms.unix;
  };
})
