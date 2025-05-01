{
  description = "My personal Nix packages repo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    h-m-m = {
      url = "github:nadrad/h-m-m";
      flake = false;
    };
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yazi-ouch-src = {
      url = "github:ndtoan96/ouch.yazi";
      flake = false;
    };
    yazi-glow-src = {
      url = "github:Reledia/glow.yazi";
      flake = false;
    };
    yazi-hexyl-src = {
      url = "github:Reledia/hexyl.yazi";
      flake = false;
    };
    yazi-restore-src = {
      url = "github:boydaihungst/restore.yazi";
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
