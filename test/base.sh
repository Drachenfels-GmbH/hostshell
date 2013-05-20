EXIT_ON_FAILURE=true
DEBUG=true

run_test_case() {
    echo "* TEST: $@"
    $@ || fail_test_case
    $EXIT_ON_FAILURE && echo "=> success"
}

fail_test_case() {
    tput bel
    echo "  Condition failed"
    exit 1
}

pending_test_case() {
    echo "  NOT IMPLEMENTED"
}

# Compares strings stored in variables `EXPECTED` and `ACTUAL`
expect_condition() {
    local condition="$@"
    echo "testing condition -->" $condition
    if eval $condition; then
        return 0
    else
        $EXIT_ON_FAILURE && fail_test_case || return 1
    fi
}

expect_true() {
    expect_condition "[ $@ ]"
}

expect_false() {
    expect_condition "! [ $@ ]"
}

expect_return() {
    expect_condition "[ "$RET" $@ ]"
}