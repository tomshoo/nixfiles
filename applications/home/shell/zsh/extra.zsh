__get_nix_status() {
    [ -n "$IN_NIX_SHELL" ] && printf "(nix:$IN_NIX_SHELL)"
}

export PROMPT="\$(__get_nix_status)${PROMPT}"
