# build a package
build package="default":
    nix-build -A packages.{{ package }}

# enter a devShell
shell shell="default":
    nix-shell default.nix -A devShells.{{ shell }}

# list attributes
list attr="packages":
    nix eval --file default.nix {{ attr }} --json | jq
