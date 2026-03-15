<div align="center">
█▄░█ ▀█▀ ▀▄▀ ▄▄ █▀█ ▄▀█ ▄▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀<br>
█░▀█ ▄█▄ ▄▀▄ ⠀⠀ █▀▀ █▀█ ▀▄▄ █░█ █▀█ █▄█ ██▄ ▄█

---

My personal Nix packages repo.
</div>

> [!NOTE]
> You can use this flake as you wish, but I may not test or update it rigorously.

## How to use

Add this flake to your's.

```Nix
{
  inputs = {
    nix-packages.url = "github:PierreBorine/nix-packages";
  };
}
```

Install individual packages

```Nix
{inputs, pkgs, ...}: {
  home.packages = [
    inputs.nix-packages.packages.${pkgs.hostPlatform.system}.<package_name>
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

## Packages

| Name                                                                                            | Description                                                 |
|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| ⌨️ <kbd><a href="https://github.com/not-jan/apex-tux"><b>apex-tux</b></a></kbd>                 | Use the OLED screen on Steelseries Apex keyboards           |
| 🖊️ <kbd><a href="https://www.dafont.com/asciid.font"><b>asciid</b></a></kbd>                    | A ascii themed font                                         |
| 💧 <kbd><a href="https://github.com/themanyfaceddemon/Barotrauma_Modding_Tool"><b>barotrauma-modding-tool</b></a></kbd> | Mod utility for the game Barotrauma |
| 💧 <kbd><a href="https://github.com/Jlobblet/Barotrauma-Save-Decompressor"><b>barotrauma-save-decompressor</b></a></kbd>| Decompress Barotrauma saves         |
| 🔧 <kbd><a href="https://github.com/hoffstadt/DearPyGui"><b>dearpygui</b></a></kbd>             | Graphical User Interface Toolkit for Python                 |
| #️⃣  <kbd><a href="https://github.com/junkdog/exabind"><b>exabind</b></a></kbd>                   | Animated TUI for viewing keyboard shortcuts                 |
| 💽 <kbd><a href="https://github.com/nschlia/ffmpegfs"><b>ffmpegfs</b></a></kbd>                 | FUSE-based transcoding filesystem with ffmpeg               |
| ⚗️ <kbd><a href="https://github.com/Dealman/Frankensteiner"><b>frankensteiner</b></a></kbd>     | Windows program to edit Mordhau mercenaries faces           |
| 💫 <kbd><a href="https://github.com/ikz87/GLWall"><b>glwall</b></a></kbd>                       | Fragment shader renderer for live and responsive wallpapers |
| 🧨 <kbd><a href="https://github.com/v4n00/h2mm-cli"><b>h2mm-cli</b></a></kbd>                   | Helldivers 2 Mod Manager CLI                                |
| ❄️ <kbd><b>header-gen</b></kbd>                                                                 | Custom Bash script to generate fancy comment headers        |
| 🎸 <kbd><a href="https://github.com/Dimencia/LuteBot3"><b>lutebot</b></a></kbd>                 | Windows program to help play music on Mordhau ([install guide](https://github.com/PierreBorine/nix-packages/tree/master/pkgs/lutebot/README.md))|
| 🥞 <kbd><a href="https://github.com/o-reo/push_swap_visualizer"><b>push-swap-visualizer</b></a></kbd>| Graphical visualizer for the 42 shool push_swap project|
| 🧠 <kbd><a href="https://github.com/ilya-fedin/qt6ct"><b>qt6ct-kde</b></a></kbd>                | Fork of qt6ct with KDE color-schemes support                |
| ⬇️ <kbd><a href="https://github.com/fiso64/slsk-batchdl"><b>slsk-batchdl</b></a></kbd>          | Advanced download tool for Soulseek                         |
| 🎵 <kbd><a href="https://github.com/spotify2tidal/spotify_to_tidal"><b>spotify-to-tidal</b></a></kbd>| Command line tool for importing Spotify playlists into Tidal|
| 🖌️ <kbd><a href="https://github.com/ChausseBenjamin/termpicker"><b>termpicker</b></a></kbd>     | A color picker for the terminal                             |
| 🎮 <kbd><a href="https://pypi.org/project/vgamepad"><b>vgamepad</b></a></kbd>                   | Virtual XBox360 and DualShock4 gamepads in python           |
| 📊 <kbd><a href="https://github.com/sahaj-b/wakafetch"><b>wakafetch</b></a></kbd>               | Terminal dashboard for WakaTime/Wakapi                      |

## NixOS Modules

### Apex Tux

Install Apex Tux and add the necessary udev rule.

```Nix
{inputs, ...}: {
  imports = [inputs.nix-packages.nixosModules.apex-tux]; # or `default`

  programs.apex-tux.enable = true;
}
```
