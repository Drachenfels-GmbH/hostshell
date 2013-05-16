#!/bin/bash
# append `-x` to bash command to enable debugging or
# use `set -x` from withing the script

# $1: the file to load
function test_require {
    FILE_BASENAME="$(dirname $0)"
    . $FILE_BASENAME/$1
}

function run_test {
    echo "* test: $@"
    $@
    echo "  result: $TEST_RESULT"
}

# Compares strings stored in variables `EXPECTED` and `ACTUAL`
function actual_to_match_expected {
    local condition="[ \"$ACTUAL\" == \"$EXPECTED\" ]"
    echo "condition: $condition"
    if eval $condition; then
        TEST_RESULT="success"
    else
        echo "  failure: Strings are not equal."
        TEST_RESULT="failure"
    fi
}

function return_to_match_expected {
    ACTUAL=$RET
    actual_to_match_expected
}

function expect {
    echo "expect #$@:"
    $@
}

# TODO collect overall result and set exit value to 1 on failure

for testfile in $(ls test/test-*.sh); do
  echo; echo "file: $testfile"
  echo "-----------------------"
  . $testfile
done
