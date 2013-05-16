DEBUG="true"

test_require 'lib/base.sh'

function my_function {
    RET="$@"
}
function my_test_case {
    call_function_if_exists my_function 'foo' 'bar' 'baz'
    EXPECTED="foo bar baz"
    expect 'return_to_match_expected'
}

run_test my_test_case