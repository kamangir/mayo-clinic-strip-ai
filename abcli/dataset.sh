#! /usr/bin/env bash

function mcsai_dataset() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "mcsai dataset download file_path_1" \
            "download file_path_1 from mcsai dataset."
        abcli_help_line "mcsai dataset list [count=10]" \
            "list [first 10 files in] mcsai dataset."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m mayo_clinic_strip_ai.dataset --help
        fi

        return
    fi

    if [ "$task" == "download" ] ; then
        local file_path="$2"
        if [ -z "$file_path" ] ; then
            abcli_log_error "-mcsai: dataset: download: missing file path."
            return
        fi

        local filename=$(basename $file_path)
        if [ -f "$abcli_object_path/$filename" ] ; then
            abcli_log "mcsai: $filename already exists, skipping download."
        else
            abcli_log "mcsai: downloading $filename..."

            kaggle competitions download -c mayo-clinic-strip-ai -f "$file_path"

            unzip $filename.zip
            rm $filename.zip
        fi

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