#!/usr/bin/env bash
# WARN: This script has no posix compliance

connect_tmux_session() {
    tmux has-session -t "$session" &> /dev/null \
    && if [[ -n "$TMUX" ]]; then tmux switch-client -t "$session";
                            else tmux attach-session -t "$session";
       fi
}

truncate_dirname() {
    printf '%s' "$(echo "$1"|rev|cut -d/ -f'-2'|rev)"
}

make_tmux_session() {
    if [[ -n "$TMUX" ]]; then
        tmux new-session -d -s "$session"
        tmux switch-client -t "$session"
    else
        tmux new-session -s "$session"
    fi
}

interactive=false
session="$(truncate_dirname "$PWD")"

while getopts :is: opt; do
    case "$opt" in
    i) interactive=true  ;;
    s) session="$OPTARG" ;;
    ?)  printf "error: unknown argument '%s'\n" "$OPTARG"

        # shellcheck disable=SC2016
        [[ "$OPTARG" = s ]] && printf 'hint: maybe you meant `%s -s session_name`\n' "$(basename "$0")"
        printf 'usage: %s [-i] [-s session_name]\n' "$(basename "$0")"
        exit 1 ;;
    esac
done

connect_tmux_session && exit 0

if "$interactive"; then
    returncode=0
    sessiondir="$(zoxide query --interactive)" || exit $?
    pushd "$sessiondir"                        || exit $?

    session="$(truncate_dirname "$sessiondir")"
    connect_tmux_session || make_tmux_session || returncode=$?

    popd || exit $returncode
    exit $returncode
fi

if [[ "$session" = "$(truncate_dirname "$PWD")" ]]; then
    make_tmux_session || exit $?
else
    if [[ -d "$session" ]]; then dirname="$session";
    else dirname="$(zoxide query "$session")" || exit $?; fi

    pushd "$dirname"  || exit $?
    make_tmux_session || exit $?
    popd              || exit $?
fi
