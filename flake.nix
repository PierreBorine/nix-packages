{
  description = "My personal Nix packages repo";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    systems = ["x86_64-linux"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfreePredicate = pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "barotrauma-save-decompressor"
                  "hd2arsenal"
                ];
            };
          };
        });
  in {
    packages = forAllSystems (
      {pkgs, ...}: import ./pkgs pkgs
    );

    legacyPackages = forAllSystems (
      {pkgs, ...}: import ./builders pkgs
    );

    nixosModules = import ./pkgs/nixos.nix self;

    overlays.default = _: fpkgs:
      import ./pkgs fpkgs
      // import ./builders fpkgs;

    apps = forAllSystems (
      {
        system,
        pkgs,
        ...
      }: {
        update-all = let
          update = "${lib.getExe pkgs.nix-update} --flake -u --build --commit";
          updateScript = lib.pipe self.packages.${system} [
            # filter out derivations with no updateScript
            (lib.filterAttrs (_: v: v.passthru.updateScript or null != null))
            # map them to nix-update commands
            (lib.concatMapAttrsStringSep "\n" (n: _: "${update} ${n}"))
            (pkgs.writeShellScript "update-all")
          ];
        in {
          type = "app";
          program = toString updateScript;
          meta.description = "update all derivations implementing passthru.updateScript";
        };
      }
    );

    __functor = self.overlays.default;
  };
}
