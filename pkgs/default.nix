{
  packages,
  inputs,
  pkgs,
  lib,
}: let
  inherit (pkgs) callPackage;
in {
  dusage = callPackage ./dusage {};
  frankensteiner = callPackage ./frankensteiner {};
  header-gen = callPackage ./header-gen {};
  h-m-m = callPackage ./h-m-m {inherit inputs;};
  lutebot = callPackage ./lutebot {};

  yaziUtils = {
    inherit
      (import ./yaziPlugins/build-yazi-plugin.nix {
        inherit (pkgs) stdenv;
        inherit lib;
      })
      buildYaziPlugin
      ;
  };

  yaziPlugins = lib.makeExtensible (
    lib.extends
    (callPackage ./yaziPlugins/plugins.nix
      {
        inherit (packages.yaziUtils) buildYaziPlugin;
        inherit inputs;
      })
    (_: {})
  );
}
