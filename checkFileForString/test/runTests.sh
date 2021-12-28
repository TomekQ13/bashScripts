#!/bin/bash
source ../checkFileForString.sh

function test_checkFileForString() {
    # Test case functions take 3 positional arguments
    # 1 - is the test file
    # 2 - is the message to print if the check does succeed
    # 3 - is the message to print if the check does not succeed
    # The functions check for "tested string" string
    returnCode=0
    function positiveTestCase() {
        if checkFileForString $1 "tested string"
        then
            # test passed
            echo "$(tput setaf 2)checkFileForString: $2$(tput sgr 0)"
            returnCode=0
        else            
            #test not passed
            echo "$(tput setaf 1)checkFileForString: $3$(tput sgr 0)"
            returnCode=1
        fi
    }

    function negativeTestCase() {
        if ! checkFileForString $1 "tested string"
        then
            # test passed
            echo "$(tput setaf 2)checkFileForString: $2$(tput sgr 0)"
            returnCode=0
        else
            #test not passed
            echo "$(tput setaf 1)checkFileForString: $3$(tput sgr 0)"
            returnCode=1
        fi
    }

    positiveTestCase test_positive_1.txt "Positive test case 1 passed" "Positive test case 1 failed"
    positiveTestCase test_positive_2.txt "Positive test case 2 passed" "Positive test case 2 failed"
    positiveTestCase test_positive_3.txt "Positive test case 3 passed" "Positive test case 3 failed"
    negativeTestCase test_negative.txt "Negative test case passed" "Negative test case failed"
    return $returnCode
}

function test_checkAllFiles() {
    # Test checks if the checkAllFiles funtions ends with a return code 1 and echoes the correct error message
    returnCode=0
    if checkAllFiles . txt "tested string" 
    then
        # test not passed
        echo "$(tput setaf 1)checkAllFiles: The function did not return return code 1$(tput sgr 0)"
        returnCode=1
    else
        #test passed
        echo "$(tput setaf 2)checkAllFiles: The function returned return code 1$(tput sgr 0)"
        returnCode=0
    fi

    errorMessage="$(checkAllFiles . txt "tested string" true)"
    if [[ "$errorMessage" == *"String tested string was not found in file"* ]]
    then
        # test passed
        echo "$(tput setaf 2)checkAllFiles: The function returned the correct error message for a negative test case$(tput sgr 0)"
        returnCode=0
    else
        # test not passed
        echo "$(tput setaf 1)checkAllFiles: The function did not return the correct error message for a negative test case$(tput sgr 0)"
        returnCode=1
    fi
    return $returnCode
}

function runTests() {
    if test_checkFileForString && test_checkAllFiles
    then
        # tests passed
        echo "$(tput setaf 2)Overall tests status: PASSED$(tput sgr 0)"
    else            
        # tests not passed
        echo "$(tput setaf 1)Overall tests status: FAILED$(tput sgr 0)"
    fi
}

runTests
