{
  overrides ? {},
  pins ? import ./npins // overrides,
  pkgs ? import pins.nixpkgs {},
}:
# read https://noogle.dev/f/lib/fix
pkgs.lib.fix (self: let
  inherit (pkgs.lib) callPackageWith modules;
  inherit (pkgs) nixos;
  # read https://nix.dev/tutorials/callpackage.html#interdependent-package-sets
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
    cowHost = nixos [
      ./nix/hosts/cowHost/configuration.nix
      self.nixosModules.default
    ];
  };

  nixosModules = {
    # read https://noogle.dev/f/lib/modules/importApply
    cowModule = modules.importApply ./nix/modules/cowModule.nix self;
    default = self.nixosModules.cowModule;
  };
})
