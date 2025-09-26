{
  description = "My personal Nix packages repo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    GLWall = {
      url = "github:ikz87/GLWall";
      flake = false;
    };

    h2mm = {
      url = "github:v4n00/h2mm-cli";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "barotrauma-save-decompressor"
              ];
          };
        };
      in
        self.lib.mkPackages pkgs
    );

    lib.mkPackages = pkgs:
      import ./pkgs {inherit inputs pkgs;}
      // import ./builders {inherit pkgs;};
  };
}
