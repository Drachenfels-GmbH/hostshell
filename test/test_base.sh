my_function() {
    RET="$@"
}
t_call_function_if_exists() {
    call_function_if_exists my_function 'foo' 'bar' 'baz'
    expect_true "'$RET' == 'foo bar baz'"
}

t_copy_return() {
    copy_return 'BLA' my_function "hello world"
    expect_true "'$BLA' == 'hello world'"
}

run_test_case t_copy_return
run_test_case t_call_function_if_exists