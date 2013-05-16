DEBUG="true"

test_require 'lib/base.sh'

function foobar {
    RET="$@"
}

function test_copy_return {
    copy_return 'BLA' foobar "hello world"

    EXPECTED='hello world'
    ACTUAL=$BLA
    expect 'actual_to_match_expected'
}

run_test test_copy_return

