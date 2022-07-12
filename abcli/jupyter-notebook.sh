#! /usr/bin/env bash

function mcsai_notebook() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "mcsai notebook open" \
            "open mcsai notebook."
        return
    fi

    if [ "$task" == "open" ] ; then
        pushd $abcli_path_git/mayo-clinic-strip-ai > /dev/null
        abcli_notebook open openslide
        popd > /dev/null
        return
    fi

    abcli_log_error "-mcsai: notebook: $task: command not found."
}