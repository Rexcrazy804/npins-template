{
  pkgs,
  mkShellNoCC,
  cowask,
  lolask,
}:
mkShellNoCC {
  shellHook = ''
    echo "Hello Cutie ~"
  '';
  packages = [
    cowask
    lolask
    pkgs.hello
  ];
}
