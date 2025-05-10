<div align="center">
█▄░█ ▀█▀ ▀▄▀ ▄▄ █▀█ ▄▀█ ▄▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀<br>
█░▀█ ▄█▄ ▄▀▄ ⠀⠀ █▀▀ █▀█ ▀▄▄ █░█ █▀█ █▄█ ██▄ ▄█

---

My personal Nix packages repo.
</div>

> [!NOTE]
> You can use these derivations as you wish, but I may not test or update them rigorously.

## How to use
Add it in your flake's inputs
```Nix
inputs = {
  nix-packages.url = "github:PierreBorine/nix-packages";
};
```
Install packages
```Nix
{inputs, ...}: {
  home.packages = [
    inputs.nix-packages.packages.x86_64-linux.<package_name>
  ];
}
```

## Packages
| Name                                                                                                            | Description                                                       |
|-----------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| 💾 <kbd><a href="https://github.com/mihaigalos/dusage"><b>dusage</b></a></kbd>                                  | command line disk usage information tool, not in nixpkgs          |
| ⚗️ <kbd><a href="https://github.com/Dealman/Frankensteiner"><b>frankensteiner</b></a></kbd>                     | Windows program to edit Mordhau mercenaries faces                 |
| 🧠 <kbd><a href="https://github.com/nadrad/h-m-m"><b>h-m-m</b></a></kbd>                                        | Hackers Mind Map, with a fix for Dash                             |
| ❄️ <kbd><b>header-gen</b></kbd>                                                                                 | Custom Bash script to generate fancy comment headers              |
| 🎸 <kbd><a href="https://github.com/Dimencia/LuteBot3"><b>lutebot</b></a></kbd>                                 | Windows program to help play music on Mordhau ([install guide](https://github.com/PierreBorine/nix-packages/tree/master/pkgs/lutebot/README.md))|
| ⚡️ <kbd><b>yaziPlugins</b></kbd>                                                                                | [Yazi](https://github.com/sxyazi/yazi) plugins, not in nixpkgs    |
| ► ❄️ <kbd><a href="https://github.com/yazi-rs/plugins/tree/main/full-border.yazi"><b>full-border</b></a></kbd>  | Add a full border to Yazi to make it look fancier                 |
| ► ❄️ <kbd><a href="https://github.com/ndtoan96/ouch.yazi"><b>ouch</b></a></kbd>                                 | Yazi plugin to preview archives                                   |
| ► ❄️ <kbd><a href="https://github.com/yazi-rs/plugins/tree/main/git.yazi"><b>git</b></a></kbd>                  | Show the status of Git file changes as linemode in the file list  |
| ► ❄️ <kbd><a href="https://github.com/yazi-rs/plugins/tree/main/toggle-pane.yazi"><b>toggle-pane</b></a></kbd>  | Toggle the show, hide, and maximize states for different panes    |
| ► ❄️ <kbd><a href="https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi"><b>smart-enter</b></a></kbd>  | Open files or enter directories all in one key                    |
| ► ❄️ <kbd><a href="https://github.com/Reledia/glow.yazi"><b>glow</b></a></kbd>                                  | Plugin to preview markdown files with glow                        |
| ► ❄️ <kbd><a href="https://github.com/Reledia/hexyl.yazi"><b>hexyl</b></a></kbd>                                | Preview any file on Yazi using hexyl                              |
| ► ❄️ <kbd><a href="https://github.com/boydaihungst/restore.yazi"><b>restore</b></a></kbd>                       | Undo/Recover trashed files/folders                                |
