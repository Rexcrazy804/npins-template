{
  pkgs,
  mkShellNoCC,
  cowask,
  lolask,
}:
mkShellNoCC {
  packages = [
    cowask
    lolask
    pkgs.just
    pkgs.jq
  ];
}
