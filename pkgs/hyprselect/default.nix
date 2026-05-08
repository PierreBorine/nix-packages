{
  lib,
  fetchFromGitHub,
  hyprlandPlugins,
}:
hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hyprselect";
  version = "0.54.0-@1";

  src = fetchFromGitHub {
    owner = "jmanc3";
    repo = "hyprselect";
    rev = "v${finalAttrs.version}";
    hash = "sha256-IcF2TfXxxMmHgVAhHdH87jUAl5fWYbtmstUT0kkJ2Dc=";
  };

  installPhase = ''
    runHook preInstall

    install -D hyprselect.so $out/lib/libhyprselect.so

    runHook postInstall
  '';

  meta = {
    description = "A plugin that adds a desktop selection box to Hyprland";
    homepage = "https://github.com/jmanc3/hyprselect";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.linux;
  };
})
