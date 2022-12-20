__load_nix_shell() {
    [ -f shell.nix ] && nix-shell
}

cd() {
    z "$@"
    __load_nix_shell
}

__load_nix_shell
