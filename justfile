# build a package
build package="default":
    nix-build -A packages.{{ package }}

# build and run a package
run package="default" +args="":
    #!/usr/bin/env bash
    set -euo pipefail
    MAIN_PROGRAM=$(nix eval --file default.nix packages.{{ package }}.meta.mainProgram --raw)
    nix-shell default.nix -A packages.{{ package }} --run "$MAIN_PROGRAM {{ quote(args) }}"

# build and run the formatter
fmt +args=".":
    #!/usr/bin/env bash
    set -euo pipefail
    MAIN_PROGRAM=$(nix eval --file default.nix formatter.meta.mainProgram --raw)
    nix-shell default.nix -A formatter --run "$MAIN_PROGRAM {{ args }}"

# enter a devShell
shell shell="default":
    nix-shell default.nix -A devShells.{{ shell }}

# list attributes
list attr="packages":
    nix eval --file default.nix {{ attr }} --json | jq
