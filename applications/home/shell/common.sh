#!/bin/sh

load() {
    package=$1
    command=$2

    [ -z "$package" ] && echo please specify a package \
        && return 1

    if [ -z "$command" ]; then
        NIXPKGS_ALLOW_UNFREE=1 nix-shell -p "$package"
    else
        NIXPKGS_ALLOW_UNFREE=1 nix-shell -p "$package" --run "$command"
    fi
}

within() {
    if [ -f shell.nix ]; then
        nix-shell --run "$*"
    else
        echo "cannot create a nix-shell"
        return 1
    fi
}
