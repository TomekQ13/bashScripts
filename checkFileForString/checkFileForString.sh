#!/bin/bash
function checkFileForString() {
    # Function is a wrapper around grep with a -q option not to print the found match to the log
    # The function takes the following positional parameters
    # 1 - file with path to check
    # 2 - string to look for
    if grep -q "$2" $1
    then 
        # if found
        # echo "$2 found in file $1"
        return 0
    else
        # if not found
        # echo "$2 not found in file $1"
        return 1
    fi
}

function checkAllFiles() {
    # Function applies checkFileForString function to all files found in a directory with a given extension
    # The function takes following positional arguments
    # 1 - directory to check for files
    # 2 - extension of files
    # 3 - string to check
    # 4 - default: false - display error message yes (true) or no (false)
    declare -a arrayFail
    for filename in $(find $1 -type f -name "*.$2")
    do
        if ! checkFileForString $filename "$3"
        then
            arrayFail+=( $filename )
        fi
    done

    # display error for every filename added to arrayFail
    returnCode=0
    for filename in $arrayFail
    do
        if [ "$4" = "true" ]
        then
            echo "$(tput setaf 1)String $3 was not found in file $filename$(tput sgr 0)"
        fi
        returnCode=1
    done
    return $returnCode
}

