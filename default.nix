{
  overrides ? {},
  pins ? import ./npins // overrides,
  pkgs ? import pins.nixpkgs {},
}:
pkgs.lib.fix (self: let
  inherit (pkgs.lib) callPackageWith;
  callPackage = callPackageWith (pkgs // self.packages);
in {
  formatter = pkgs.alejandra;

  packages = {
    cowask = callPackage ./nix/pkgs/cowask.nix {};
    lolask = callPackage ./nix/pkgs/lolask.nix {};
    default = self.packages.cowask;
  };

  devShells = {
    cowShell = callPackage ./nix/shells/cowShell.nix {};
    default = self.devShells.cowShell;
  };
})
