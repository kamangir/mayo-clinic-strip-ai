#! /usr/bin/env bash

function mcsai_dataset() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "mcsai dataset download filename_1" \
            "download filename_1 from mcsai dataset."
        abcli_help_line "mcsai dataset list [count=10]" \
            "list [first 10 items in] mcsai dataset."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m mayo_clinic_strip_ai.dataset --help
        fi

        return
    fi

    if [ "$task" == "download" ] ; then
        kaggle competitions download -c mayo-clinic-strip-ai -f "$2"
        return
    fi

    if [ "$task" == "list" ] ; then
        local options="$2"
        local count=$(abcli_option_int "$options" "count" 99999)

        kaggle competitions \
            files \
            -c mayo-clinic-strip-ai | head -n $(python3 -c "print($count+2)")

        return
    fi

    abcli_log_error "-mcsai: dataset: $task: command not found."
}