{
  description = "My personal Nix packages repo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    h-m-m = {
      url = "github:nadrad/h-m-m";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system} = import ./pkgs {
      packages = self.packages.${system};
      inherit (nixpkgs) lib;
      inherit inputs pkgs;
    };
  };
}
