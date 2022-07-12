#! /usr/bin/env bash

function mcsai() {
    mayo_clinic_strip_ai $@
}

function mayo_clinic_strip_ai() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "abct task_1" \
            "run abct task_1."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m mayo_clinic_strip_ai --help
        fi

        return
    fi

    if [ "$task" == "task_1" ] ; then
        python3 -m mayo_clinic_strip_ai \
            task_1 \
            ${@:2}
        return
    fi

    abcli_log_error "-mayo_clinic_strip_ai: $task: command not found."
}