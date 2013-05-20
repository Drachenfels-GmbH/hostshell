t_dirname_real() {
    local suffix=$(date +%s)
    local folder="/tmp/foobar-${suffix}"
    mkdir $folder
    ln -s $folder ${folder}.symlink
    dirname_real ${folder}.symlink
    expect_return "= /tmp"
}

t_log() {
    pending_test_case
}

t_log_debug() {
    pending_test_case
}

t_default_if_false() {
    local correct_answer=42
    default_if_false "[ 42 -eq $correct_answer ]" "right"  "wrong"
    expect_true "'$RET' == 'right'"

    default_if_false "[ 66 -eq $correct_answer ]" "right"  "wrong"
    expect_false "'$RET' == 'right'"
}

t_default_if_blank() {
    local var1="myvalue"
    local blankvar=""

    default_if_blank $var1 "default"
    expect_true "'$RET' == '$var1'"
    default_if_blank $blankvar "default"
    expect_true "'$RET' == 'default'"
}

t_default_if_blank_multi() {
    pending_test_case
}

t_load_file() {
    pending_test_case
}

t_load_stdlib() {
    pending_test_case
}

run_test_case t_dirname_real
run_test_case t_log
run_test_case t_log_debug
run_test_case t_default_if_false
run_test_case t_default_if_blank
run_test_case t_load_file
run_test_case t_load_stdlib