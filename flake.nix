{
  description = "My personal Nix packages repo";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
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

    __functor = _: fpkgs:
      import ./pkgs fpkgs
      // import ./builders fpkgs;
  };
}
