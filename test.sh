#!/bin/bash

# $1: the file to load
function test_require {
    FILE_BASENAME="$(dirname $0)"
    . $FILE_BASENAME/$1
}

function run_testcase {
    local testcase=$1
    echo; echo "running test function: $1"
    $testcase
    echo "  Result: $TEST_RESULT"
}

# $1: expected value
# $2: actual value
function expect_strings_equal {
    local expected=$1
    local actual=$2

    if [ "$expected" == "$actual" ]; then
        TEST_RESULT="success"
    else
        echo "  MESSAGE: Expected strings to be equal"
        echo "  EXPECTED: $expected"
        echo "  ACTUAL:   $actual"
        TEST_RESULT="fail"
    fi
}

# TODO collect overall result

for testfile in $(ls test/test-*.sh); do
  echo "file: $testfile"
  echo "-----------------------"
  . $testfile
done
