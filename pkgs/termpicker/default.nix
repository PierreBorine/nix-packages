{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
}:
buildGoModule (finalAttrs: {
  pname = "termpicker";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "ChausseBenjamin";
    repo = "termpicker";
    rev = "v${finalAttrs.version}";
    hash = "sha256-V1ZwkvlMLTNjk6hdnpByS/7zR7U7kChuKMVP0H+BJD8=";
  };

  vendorHash = "sha256-M5YZaJdv9D8NkwD+T8tAtGH5P4IKcgjqpUoKVfLo+C0=";

  nativeBuildInputs = [versionCheckHook];

  ldflags = [
    "-s"
    "-w"
    "-X=main.version=${finalAttrs.version}"
  ];

  passthru.updateScript = nix-update-script {extraArgs = ["--flake"];};

  meta = {
    description = "A color picker for the terminal";
    homepage = "https://github.com/ChausseBenjamin/termpicker";
    license = lib.licenses.beerware;
    mainProgram = "termpicker";
  };
})
