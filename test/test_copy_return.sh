function foobar {
    RET="$@"
}

function t_copy_return {
    copy_return 'BLA' foobar "hello world"
    expect_true "'$BLA' == 'hello world'"
}

run_test_case t_copy_return

