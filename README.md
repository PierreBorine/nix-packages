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

## Packages

| Name                                                                                       | Description                                                                                                                                      |
|--------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| [apex-tux]("https://github.com/not-jan/apex-tux")                                          | Use the OLED screen on Steelseries Apex keyboards                                                                                                |
| [asciid]("https://www.dafont.com/asciid.font")                                             | A ascii themed font                                                                                                                              |
| [barotrauma-modding-tool]("https://github.com/themanyfaceddemon/Barotrauma_Modding_Tool")  | Mod utility for the game Barotrauma                                                                                                              |
| [barotrauma-save-decompressor]("https://github.com/Jlobblet/Barotrauma-Save-Decompressor") | Decompress Barotrauma saves                                                                                                                      |
| [binbreak]("https://github.com/epic-64/binbreak")                                          | Terminal based binary number guessing game                                                                                                       |
| [curv]("https://github.com/programmersd21/curv")                                           | Bezier curves lab for your terminal                                                                                                              |
| [dearpygui]("https://github.com/hoffstadt/DearPyGui")                                      | Graphical User Interface Toolkit for Python                                                                                                      |
| [exabind]("https://github.com/junkdog/exabind")                                            | Animated TUI for viewing keyboard shortcuts                                                                                                      |
| [ffmpegfs]("https://github.com/nschlia/ffmpegfs")                                          | FUSE-based transcoding filesystem with ffmpeg                                                                                                    |
| [frankensteiner]("https://github.com/Dealman/Frankensteiner")                              | Windows program to edit Mordhau mercenaries faces                                                                                                |
| [glwall]("https://github.com/ikz87/GLWall")                                                | Fragment shader renderer for live and responsive wallpapers                                                                                      |
| [h2mm-cli]("https://github.com/v4n00/h2mm-cli")                                            | Helldivers 2 Mod Manager CLI                                                                                                                     |
| [hd2arsenal]("https://www.nexusmods.com/helldivers2/mods/4664")                            | Helldivers 2 Mod Manager GUI (manual download from Nexus)                                                                                        |
| header-gen                                                                                 | Custom Bash script to generate fancy comments and headers                                                                                        |
| [hyprselect]("https://github.com/jmanc3/hyprselect")                                       | Hyprland plugin that adds a desktop selection box                                                                                                |
| [lutebot]("https://github.com/Dimencia/LuteBot3")                                          | Windows program to help play music on Mordhau ([install guide](https://github.com/PierreBorine/nix-packages/tree/master/pkgs/lutebot/README.md)) |
| [push-swap-visualizer]("https://github.com/o-reo/push_swap_visualizer")                    | Graphical visualizer for the 42 shool push_swap project                                                                                          |
| [qt6ct-kde]("https://github.com/ilya-fedin/qt6ct")                                         | Fork of qt6ct with KDE color-schemes support                                                                                                     |
| [slsk-batchdl]("https://github.com/fiso64/slsk-batchdl")                                   | Advanced download tool for Soulseek                                                                                                              |
| [spotify-to-tidal]("https://github.com/spotify2tidal/spotify_to_tidal")                    | Command line tool for importing Spotify playlists into Tidal                                                                                     |
| [termpicker]("https://github.com/ChausseBenjamin/termpicker")                              | A color picker for the terminal                                                                                                                  |
| [vgamepad]("https://pypi.org/project/vgamepad")                                            | Virtual XBox360 and DualShock4 gamepads in python                                                                                                |
| [wakafetch]("https://github.com/sahaj-b/wakafetch")                                        | Terminal dashboard for WakaTime/Wakapi                                                                                                           |

## NixOS Modules

### Apex Tux

Install Apex Tux and add the necessary udev rule.

```Nix
{inputs, ...}: {
  imports = [inputs.nix-packages.nixosModules.apex-tux]; # or `default`

  programs.apex-tux.enable = true;
}
```
