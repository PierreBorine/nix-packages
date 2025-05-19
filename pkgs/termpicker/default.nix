{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "termpicker";
  version = "1.3.9";

  src = fetchFromGitHub {
    owner = "ChausseBenjamin";
    repo = "termpicker";
    rev = "v${version}";
    hash = "sha256-51+H58wOSNTIGiZIe6ORgb4OilOVXIPms6/QESAd3dI=";
  };

  vendorHash = "sha256-otLMQ8Ay7tiMoHZ+yzbxNpOzvD2dCsqxOo9gweBUTb0=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.version=${version}"
  ];

  meta = {
    description = "A color picker for the terminal";
    homepage = "https://github.com/ChausseBenjamin/termpicker";
    license = lib.licenses.beerware;
    mainProgram = "termpicker";
  };
}
