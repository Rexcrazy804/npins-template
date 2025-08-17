# we can call nix-shell --argstr shell "<shellname>"
# for other devShells
{shell ? "default"}: (import ./. {}).devShells.${shell}
