█░░ █░█ ▀█▀ █▀▀ █▄▄ █▀█ ▀█▀<br>
█▄▄ █▄█ ░█░ ██▄ █▄█ █▄█ ░█░

## How to use

### 1. Preparation
- Make sure to launch Mordhau at least once.
- Have **Wine** and **Protontricks** installed.

### 2. Installation
1. Download the [.NET 7](https://dotnet.microsoft.com/en-us/download/dotnet/7.0) Desktop Runtime. ([quick download link](https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/7.0.20/windowsdesktop-runtime-7.0.20-win-x64.exe))
2. Install the Desktop Runtime in Mordhau's proton prefix.
```sh
protontricks -c "wine path/to/the/downloaded/exe" 629760
```

3. Install this Lutebot package using Nix.
> [!IMPORTANT]
> Having **Wine** installed globally is a requierment.
```Nix
{inputs, ...}: {
  home.packages = [inputs.nix-packages.packages.x86_64-linux.lutebot];
}
```

### 3. First launch
1. Launch Lutebot through your usual mean of launching applications.
2. Give Lutebot Mordhau's installation path. Usually something like this:<br>
`/home/<user>/.steam/steam/steamapps/common/Mordhau/Mordhau.exe`
3. Agree to install Lutemod

### 4. Enjoy

> [!NOTE]
> Don't forget you can configure Lutemod in a local match by typing `~keybinds` in the chat.
