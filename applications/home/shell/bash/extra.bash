#!/usr/bin/env bash
      
nix-index-fetch() {
    filename="index-$(uname -m)-$(uname | tr A-Z a-z)"
    [ ! -d ~/.cache/nix-index ] && mkdir ~/.cache/nix-index
    pushd ~/.cache/nix-index/ || return 1
    wget -q -N "https://github.com/Mic92/nix-index-database/releases/latest/download/$filename"
    ln -f "$filename" files
    popd || return 1
  }
