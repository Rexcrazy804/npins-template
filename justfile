REBUILD_CMD := require('nixos-rebuild')

alias rb := rebuild
alias sh := develop

_default:
    @just -l

# list attributes
[group("extra")]
list attr="packages":
    nix eval --file default.nix {{ attr }} --json | jq

# update npins sources
[group("extra")]
update +sources='':
    npins update {{ sources }}

# build a package
[group("nix")]
build package="default":
    nix-build -A packages.{{ package }}

# build and run a package
[group("nix")]
run package="default" +args="": (_run ("packages." + package) args)

# build and run the formatter
[group("nix")]
fmt +args=".": (_run "formatter" args)

_run attr args:
    #!/usr/bin/env nix-shell 
    #!nix-shell -i bash {{ `pwd` }}/default.nix -A {{ attr }}
    set -euo pipefail
    MAIN_PROGRAM=$(nix eval --file default.nix {{ attr }}.meta.mainProgram --raw)
    $MAIN_PROGRAM {{ args }}

# enter a devShell
[group("nix")]
develop shell="default":
    nix-shell default.nix -A devShells.{{ shell }}

# rebuild nixos configuration
[group("nixos")]
rebuild cmd host=`hostname` +args='':
    {{ REBUILD_CMD }} --log-format bar --no-reexec --file . -A nixosConfigurations.{{ host }} {{ cmd }} {{ args }}
