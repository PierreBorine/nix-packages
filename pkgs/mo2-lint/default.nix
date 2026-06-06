# With help of: https://github.com/HPCesia/nur-packages/blob/6cc7925159/pkgs/mo2-lint/default.nix
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  fetchurl,
  toPythonModule,
  makePythonPath,
  writableTmpDirAsHomeHook,
  # build deps
  wineWow64Packages,
  curl,
  unzip,
  pyinstaller,
  python,
  pip,
  # runtime deps
  chardet,
  certifi,
  click,
  python-dotenv,
  inquirerpy,
  loguru,
  packaging,
  patool,
  psutil,
  pydantic,
  pyyaml,
  requests,
  send2trash,
  websockets,
  protontricks,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mo2-lint";
  version = "7.0.0-rc3";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "Furglitch";
    repo = "modorganizer2-linux-installer";
    tag = finalAttrs.version;
    hash = "sha256-XZgI09b1h9U6znn6HC1kO5Hru9dVbZWOxlnwOCmih0k=";
  };

  nativeBuildInputs = [
    pyinstaller

    wineWow64Packages.stable
    writableTmpDirAsHomeHook
    # not actually used, but necessary for make to succeed
    curl
    unzip
  ];

  postPatch = ''
    # Bump logging level to hide unnecessary stuff
    substituteInPlace src/mo2-lint/__init__.py \
      --replace-fail 'log_level="TRACE"' 'log_level="WARNING"'

    # - Lets not use uv
    # - Use Nix instead of curl to download dependencies
    # - Show pyinstaller where the python deps are
    substituteInPlace Makefile \
      --replace-fail 'uv run ' "" \
      --replace-fail \
        'curl -# -L https://www.python.org/ftp/python/3.13.0/python-3.13.0-embed-amd64.zip -o python-3.13.0-embed-amd64.zip' \
        'cp ${finalAttrs.passthru.python-embed} ./python-3.13.0-embed-amd64.zip' \
      --replace-fail \
        'curl -# -L https://bootstrap.pypa.io/get-pip.py -o get-pip.py' \
        'cp ${finalAttrs.passthru.get-pip} ./get-pip.py' \
      --replace-fail '--paths src' '--paths src --paths "${finalAttrs.passthru.runtimeDeps}"'

    # Use our pre-fetched dependencies
    substituteInPlace Makefile \
      --replace-fail 'python.exe get-pip.py' 'python.exe get-pip.py --no-index --find-links=Z:${finalAttrs.passthru.windows-python-deps}' \
      --replace-fail '-q --upgrade pip' '--no-index --find-links=Z:${finalAttrs.passthru.windows-python-deps}'
  '';

  buildPhase = ''
    runHook preBuild

    make _build

    # keep this to assert the file was created
    ls -l dist/mo2-redirector.exe

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications
    cp dist/mo2-lint dist/nxm-handler $out/bin
    mv configs/nxm-handler.desktop $out/share/applications
    cp -r configs $out/share/mo2-lint

    substituteInPlace $out/share/applications/nxm-handler.desktop \
      --replace-fail '$HOME/.local/share/mo2-lint/nxm-handler' "$out/bin/nxm-handler"

    runHook postInstall
  '';

  passthru = {
    get-pip = fetchurl {
      url = "https://raw.githubusercontent.com/pypa/get-pip/refs/tags/26.1.1/public/get-pip.py";
      hash = "sha256-ZpBLzLh442PbYjbqkA5pNeUH3LiH6fF49iEu3+f0anY=";
    };

    python-embed = fetchurl {
      url = "https://www.python.org/ftp/python/3.13.0/python-3.13.0-embed-amd64.zip";
      hash = "sha256-AcMtBzdDIkCtzwu8HTIyfwl206HhQnd0vI/ryPHAMRE=";
    };

    windows-python-deps = stdenvNoCC.mkDerivation {
      name = "mo2-win-pip-wheels";

      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = "sha256-+eWwyjSzkpr8V/c4M0K/PZjsXt6TUDBlphkrz+umBLg=";

      nativeBuildInputs = [python pip];

      buildCommand = ''
        mkdir -p $out
        export PIP_CACHE_DIR=$TMPDIR/pip-cache

        pip download \
          --platform win_amd64 \
          --python-version 3.13 \
          --only-binary=:all: \
          --dest $out \
          --requirement ${./requirements.txt}
      '';
    };

    runtimeDeps = makePythonPath [
      chardet # not mentioned anywhere
      certifi
      click
      python-dotenv
      inquirerpy
      loguru
      packaging
      patool
      psutil
      pydantic
      pyyaml
      requests
      send2trash
      websockets
      (toPythonModule protontricks)
    ];
  };

  meta = {
    description = "An easy-to-use Mod Organizer 2 installer for Linux";
    homepage = "https://github.com/Furglitch/modorganizer2-linux-installer";
    changelog = "https://github.com/Furglitch/modorganizer2-linux-installer/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl3Plus;
    mainProgram = "mo2-lint";
    platforms = ["x86_64-linux"];
  };
})
