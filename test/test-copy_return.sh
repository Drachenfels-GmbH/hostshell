DEBUG="true"

test_require 'lib/base.sh'

function hello_world {
    RET="$@"
}

function test_copy_return {
    copy_return 'BLA' hello_world 'hello ' 'world'
    expect_strings_equal "hello world" $BLA
}

run_testcase test_copy_return

