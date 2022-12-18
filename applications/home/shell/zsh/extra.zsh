cd() {
    z "$@"
    if [[ -a shell.nix ]] && [ -z "$NIX_SHELL_ACTIVE" ]; then
        export NIX_SHELL_ACTIVE=1
        nix-shell
    fi
}
