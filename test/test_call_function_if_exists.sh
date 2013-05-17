function my_function {
    RET="$@"
}
function t_call_function_if_exists {
    call_function_if_exists my_function 'foo' 'bar' 'baz'
    expect_true "'$RET' == 'foo bar baz'"
}

run_test_case t_call_function_if_exists