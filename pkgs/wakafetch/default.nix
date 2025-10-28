{
  lib,
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule (finalAttrs: {
  pname = "wakafetch";
  version = "9adc20e10e87d1ad53e22a1ef94c9df326ccf0c2";

  src = fetchFromGitHub {
    owner = "sahaj-b";
    repo = "wakafetch";
    rev = finalAttrs.version;
    sha256 = "sha256-u78bftzwoNxsLz91SFnAPwnPQ6++52cxk/6WwK8PdLc=";
  };

  vendorHash = null;

  meta = {
    description = "Terminal dashboard for your WakaTime/Wakapi coding activity";
    homepage = "https://github.com/sahaj-b/wakafetch";
    license = lib.licenses.mit;
    mainProgram = "wakafetch";
  };
})
