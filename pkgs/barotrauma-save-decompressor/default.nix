{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
}:
buildDotnetModule (finalAttrs: {
  pname = "barotrauma-save-decompressor";
  version = "1.5.0.0";

  src = fetchFromGitHub {
    owner = "Jlobblet";
    repo = "Barotrauma-Save-Decompressor";
    rev = "v${finalAttrs.version}";
    hash = "sha256-CkHaD3LZaOhohYRVJsGI48WdhcX3ww5mYr3/7XSTa14=";
  };

  projectFile = "Barotrauma-Save-Decompressor-CLI/Barotrauma-Save-Decompressor-CLI.csproj";
  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;
  nugetDeps = ./nuget-deps.json;

  postPatch = ''
    substituteInPlace ${finalAttrs.projectFile} \
      --replace-warn '<EnableCompressionInSingleFile>true</EnableCompressionInSingleFile>' "" \
      --replace-fail "net6.0" "net8.0" \
      --replace-fail "</PropertyGroup>" "<AssemblyName>barotrauma-save-decompressor</AssemblyName></PropertyGroup>"
  '';

  meta = {
    description = "Decompress and compress Barotrauma save files";
    homepage = "https://github.com/Jlobblet/Barotrauma-Save-Decompressor";
    license = lib.licenses.unfree;
    mainProgram = "barotrauma-save-decompressor";
    platforms = lib.platforms.all;
  };
})
