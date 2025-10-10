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
      {pkgs, ...}: self.lib.mkPackages pkgs
    );

    legacyPackages = forAllSystems (
      {pkgs, ...}: pkgs.callPackage ./builders {}
    );

    lib.mkPackages = pkgs:
      pkgs.callPackage ./pkgs {inherit inputs;};

    nixosModules = import ./pkgs/nixos.nix self;
  };
}
