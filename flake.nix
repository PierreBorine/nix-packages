{
  description = "My personal Nix packages repo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    GLWall = {
      url = "github:ikz87/GLWall";
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
    packages.${system} = import ./pkgs {inherit inputs pkgs;};
  };
}
