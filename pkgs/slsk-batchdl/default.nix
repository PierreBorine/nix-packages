{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
}:
buildDotnetModule (finalAttrs: {
  pname = "slsk-batchdl";
  version = "2.5.0";

  src = fetchFromGitHub {
    owner = "fiso64";
    repo = "slsk-batchdl";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-ZgNjNdk03jIc/REJMmuc5rZLbibLoy94DJxh7jAJY7g=";
  };

  projectFile = "slsk-batchdl/slsk-batchdl.csproj";

  # nix build .#slsk-batchdl.fetch-deps
  # ./result nuget-deps.json
  nugetDeps = ./nuget-deps.json;

  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  # Patch the project file to use .NET 8
  # https://github.com/fiso64/slsk-batchdl/issues/112
  postPatch = ''
    substituteInPlace slsk-batchdl/slsk-batchdl.csproj \
      --replace-fail "net6.0" "net8.0"
  '';

  doCheck = false;

  meta = with lib; {
    description = "A batch downloader for Soulseek";
    homepage = "https://github.com/fiso64/slsk-batchdl";
    platforms = platforms.linux;
    mainProgram = "slsk-batchdl";
  };
})
