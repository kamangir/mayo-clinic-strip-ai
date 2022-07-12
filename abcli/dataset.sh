#! /usr/bin/env bash

function mcsai_dataset() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "mcsai dataset download object_1" \
            "download object_1 from mcsai dataset."
        abcli_help_line "mcsai dataset list [count=10]" \
            "list [first 10 files in] mcsai dataset."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m mayo_clinic_strip_ai.dataset --help
        fi

        return
    fi

    if [ "$task" == "download" ] ; then
        local object_name="$2"
        if [ -z "$object_name" ] ; then
            abcli_log_error "-mcsai: dataset: download: missing object."
            return
        fi
        if [ "$(abcli_keyword_is $object_name validate)" == true ] ; then
            local object_name="other/04414e_0.tif"
        fi

        local filename=$(basename $object_name)
        local filepath=$(dirname $object_name)

        if [ -f "$abcli_object_path/$filepath/$filename" ] ; then
            abcli_log "mcsai: $filepath/$filename already exists, skipping download."
        else
            abcli_log "mcsai: downloading $filepath/$filename..."

            kaggle competitions download -c mayo-clinic-strip-ai -f $object_name

            unzip $filename.zip
            rm $filename.zip

            mkdir -p $filepath
            mv -v $filename $filepath/$filename
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