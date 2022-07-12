#! /usr/bin/env bash

function mcsai_dataset() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "mcsai dataset list" \
            "list mcsai dataset."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m mayo_clinic_strip_ai.dataset --help
        fi

        return
    fi

    if [ "$task" == "list" ] ; then
        kaggle competitions files -c mayo-clinic-strip-ai
        return
    fi

    abcli_log_error "-mcsai: dataset: $task: command not found."
}