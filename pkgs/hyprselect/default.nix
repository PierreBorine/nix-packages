{
  lib,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
  hyprlandPlugins,
}:
hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hyprselect";
  version = "0.56.1-@1";

  src = fetchFromGitHub {
    owner = "jmanc3";
    repo = "hyprselect";
    rev = "v${finalAttrs.version}";
    hash = "sha256-6YMUG77UCkWDDgQSXIBa8dVU6PCRZaPW5l1KYL2vtc8=";
  };

  nativeBuildInputs = [versionCheckHook];

  installPhase = ''
    runHook preInstall

    install -D hyprselect.so $out/lib/libhyprselect.so

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {extraArgs = ["--flake"];};

  meta = {
    description = "A plugin that adds a desktop selection box to Hyprland";
    homepage = "https://github.com/jmanc3/hyprselect";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.linux;
    maintainers = [lib.maintainers.pierreborine];
  };
})
