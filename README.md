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
| Name                                                                                            | Description                                                 |
|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| 💾 <kbd><a href="https://github.com/themanyfaceddemon/Barotrauma_Modding_Tool"><b>barotrauma-modding-tool</b></a></kbd> | Mod utility for the game Barotrauma |
| 💾 <kbd><a href="https://github.com/hoffstadt/DearPyGui"><b>dearpygui</b></a></kbd>             | Graphical User Interface Toolkit for Python                 |
| 💾 <kbd><a href="https://github.com/mihaigalos/dusage"><b>dusage</b></a></kbd>                  | Command line disk usage information tool                    |
| ⚗️ <kbd><a href="https://github.com/Dealman/Frankensteiner"><b>frankensteiner</b></a></kbd>     | Windows program to edit Mordhau mercenaries faces           |
| 💫 <kbd><a href="https://github.com/ikz87/GLWall"><b>glwall</b></a></kbd>                       | Fragment shader renderer for live and responsive wallpapers |
| 🧠 <kbd><a href="https://github.com/nadrad/h-m-m"><b>h-m-m</b></a></kbd>                        | Hackers Mind Map, with a fix for Dash                       |
| ❄️ <kbd><b>header-gen</b></kbd>                                                                 | Custom Bash script to generate fancy comment headers        |
| 🎸 <kbd><a href="https://github.com/Dimencia/LuteBot3"><b>lutebot</b></a></kbd>                 | Windows program to help play music on Mordhau ([install guide](https://github.com/PierreBorine/nix-packages/tree/master/pkgs/lutebot/README.md))|
| 🖌️ <kbd><a href="https://github.com/ChausseBenjamin/termpicker"><b>termpicker</b></a></kbd>     | A color picker for the terminal                             |
| 🎮 <kbd><a href="https://pypi.org/project/vgamepad"><b>vgamepad</b></a></kbd>                   | Virtual XBox360 and DualShock4 gamepads in python           |
