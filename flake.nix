{
  description = "My personal Nix packages repo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
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
      {pkgs, ...}: import ./pkgs pkgs inputs
    );

    legacyPackages = forAllSystems (
      {pkgs, ...}: import ./builders pkgs
    );

    nixosModules = import ./pkgs/nixos.nix self;

    __functor = _: fpkgs:
      import ./pkgs fpkgs inputs
      // import ./builders fpkgs;
  };
}
