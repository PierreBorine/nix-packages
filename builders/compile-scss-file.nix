{
  runCommand,
  dart-sass,
}: name: src:
runCommand name {
  inherit src;
  passAsFile = ["text"];
  nativeBuildInputs = [dart-sass];
} ''
  sass --no-source-map $src:${name}
  cp ${name} $out
''
