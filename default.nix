{
  overrides ? {},
  pins ? import ./npins // overrides,
  pkgs ? import pins.nixpkgs {},
}:
pkgs.lib.fix (self: let
  inherit (pkgs.lib) callPackageWith;
  inherit (pkgs) nixos;
  callPackage = callPackageWith (pkgs // self.packages);
in {
  formatter = pkgs.alejandra;

  packages = {
    cowask = callPackage ./nix/pkgs/cowask.nix {};
    lolask = callPackage ./nix/pkgs/lolask.nix {};
    default = self.packages.cowask;
    cowVM = self.nixosConfigurations.cowHost.config.system.build.vm;
  };

  devShells = {
    cowShell = callPackage ./nix/shells/cowShell.nix {};
    default = self.devShells.cowShell;
  };

  nixosConfigurations = {
    cowHost = nixos [./nix/hosts/cowHost/configuration.nix];
  };
})
