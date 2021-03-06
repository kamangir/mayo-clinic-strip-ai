#! /usr/bin/env bash

function mayo_clinic_strip_ai() {
    mcsai $@
}

function mcsai() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        mcsai_dataset $@

        abcli_help_line "mcsai install" \
            "install mcsai."

        mcsai_notebook $@

        abcli_help_line "mcsai validate" \
            "validate mcsai."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m mcsai --help
        fi

        return
    fi

    if [[ $(type -t mcsai_$task) == "function" ]] ; then
        mcsai_$task ${@:2}
        return
    fi

    if [ "$task" == "install" ] ; then
        if [ "$abcli_is_mac" == true ] ; then
            # https://openslide.org/api/python/
            brew install openslide
            python3 -m pip install openslide-python
        fi
        return
    fi

    if [ "$task" == "validate" ] ; then
        python3 -m mcsai \
            validate \
            ${@:2}
        return
    fi

    abcli_log_error "-mcsai: $task: command not found."
}