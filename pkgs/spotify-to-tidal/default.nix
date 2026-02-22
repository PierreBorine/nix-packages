{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  setuptools,
  spotipy,
  tidalapi,
  pyaes,
  pyyaml,
  tqdm,
  sqlalchemy,
  pytest,
  pytest-mock,
}:
buildPythonPackage rec {
  pname = "spotify-to-tidal";
  version = "1.0.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "spotify2tidal";
    repo = "spotify_to_tidal";
    tag = "v${version}";
    hash = "sha256-7J3rEdqS5AJZnNW3J+x54EJ4Wjh112GnASrH1SCRkG4=";
  };

  build-system = [setuptools];

  dependencies = [
    spotipy
    tidalapi
    pyaes
    pyyaml
    tqdm
    sqlalchemy
    pytest
    pytest-mock
  ];

  meta = {
    description = "A command line tool for importing your Spotify playlists into Tidal";
    homepage = "https://github.com/spotify2tidal/spotify_to_tidal";
    changelog = "https://github.com/spotify2tidal/spotify_to_tidal/releases/tag/v${version}";
    license = lib.licenses.agpl3Only;
  };
}
