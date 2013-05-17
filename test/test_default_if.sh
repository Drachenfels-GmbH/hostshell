function t_default_if {
    local correct_answer=42
    default_if_false "[ 42 -eq $correct_answer ]" "right"  "wrong"
    expect_true "'$RET' == 'right'"

    default_if_false "[ 66 -eq $correct_answer ]" "right"  "wrong"
    expect_false "'$RET' == 'right'"
}

function t_default_if_blank {
    local var1="myvalue"
    local blankvar=""

    default_if_blank $var1 "default"
    expect_true "'$RET' == '$var1'"
    default_if_blank $blankvar "default"
    expect_true "'$RET' == 'default'"
}

function t_default_if_blank_multi {
    pending_test_case
}

run_test_case t_default_if
run_test_case t_default_if_blank
run_test_case t_default_if_blank_multi