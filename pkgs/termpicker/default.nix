{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule (finalAttrs: {
  pname = "termpicker";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "ChausseBenjamin";
    repo = "termpicker";
    rev = "v${finalAttrs.version}";
    hash = "sha256-KLoI2NfolWdi4IXTa4s+n4eDLVtsmp8s1H8hSJqZvmw=";
  };

  vendorHash = "sha256-M5YZaJdv9D8NkwD+T8tAtGH5P4IKcgjqpUoKVfLo+C0=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.version=${finalAttrs.version}"
  ];

  meta = {
    description = "A color picker for the terminal";
    homepage = "https://github.com/ChausseBenjamin/termpicker";
    license = lib.licenses.beerware;
    mainProgram = "termpicker";
  };
})
