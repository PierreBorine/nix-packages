<div align="center">
█▄░█ ▀█▀ ▀▄▀ ▄▄ █▀█ ▄▀█ ▄▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀<br>
█░▀█ ▄█▄ ▄▀▄ ⠀⠀ █▀▀ █▀█ ▀▄▄ █░█ █▀█ █▄█ ██▄ ▄█

---

My personal Nix packages repo.
</div>

> [!NOTE]
> Most of these derivations I wrote myself but some where copied from other
> places when I didn't feel like depending on another flake.
> Sources mostly included.

## How to use

Add this flake to your's.

```Nix
{
  inputs = {
    nix-packages.url = "git+https://codeberg.org/PierreBorine/nix-packages.git";
  };
}
```

Install individual packages

```Nix
{inputs, pkgs, ...}: {
  home.packages = [
    inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.<package_name>
  ];
}
```

or add them to a custom namespace of `pkgs` using an overlay

```Nix
{inputs, pkgs, ...}: {
  nixpkgs.overlays = [
    (_: prev: {my = inputs.nix-packages prev;})
  ];

  environment.systemPackages = [pkgs.my.<package_name>];
}
```

## NixOS Modules

### Apex Tux

Install Apex Tux and add the necessary udev rule.

```Nix
{inputs, ...}: {
  imports = [inputs.nix-packages.nixosModules.apex-tux]; # or `default`

  programs.apex-tux.enable = true;
}
```
