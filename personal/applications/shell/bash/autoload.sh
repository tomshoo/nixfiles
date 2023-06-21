#!/usr/bin/env bash

function autoload() {
    local dir="$1"    &&
        [ "$1" ]      &&
        shift         &&
        autoload "$@"

    if [ -d "$dir" ]             &&
       [ -x "$dir" ]             &&
       pushd "$dir" &>/dev/null;
    then
        for func in *; do
            [[ "$func" =~ ^[_a-zA-Z][_a-zA-Z0-9]*$ ]]                &&
                alias $func="source $PWD/$func; unalias $func;$func"
        done
        popd &> /dev/null || return 0
    fi
}
