#! /usr/bin/env bash

function mcsai() {
    mayo_clinic_strip_ai $@
}

function mayo_clinic_strip_ai() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "mcsai install" \
            "install mcsai."
        abcli_help_line "mcsai validate" \
            "validate mcsai."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m mayo_clinic_strip_ai --help
        fi

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
        python3 -c "from openslide import OpenSlide"
        return
    fi

    abcli_log_error "-mayo_clinic_strip_ai: $task: command not found."
}