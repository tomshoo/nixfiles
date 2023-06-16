#!/usr/bin/env bash

function autoload() 
  { local dir="$1" && [ "$1" ] && shift && autoload "$@"
    local ident='^[_a-zA-Z][_a-zA-Z0-9]*$'

    if [ -d "$dir" -a -x "$dir" ] && pushd "$dir" &>/dev/null; then
        for func in *; do
            if [[ "$func" =~ ^[_a-zA-Z][_a-zA-Z0-9]*$ ]]; then
                alias $func="source $PWD/$func; unalias $func;$func"
            else
                echo "[ERROR]: $func is not a valid identifier" 1>&2
            fi
        done
        popd &> /dev/null
    fi
  }
