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
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in
        import ./pkgs {inherit inputs pkgs;}
    );

    lib.mkPackages = pkgs:
      import ./pkgs {inherit inputs pkgs;};
  };
}
