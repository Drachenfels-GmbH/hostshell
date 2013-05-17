EXIT_ON_FAILURE=true
DEBUG=true

function run_test_case {
    echo "* TEST: $@"
    $@
    $EXIT_ON_FAILURE && echo "=> success"
}

function fail_test_case {
    tput bel
    echo "  Condition failed"
    exit 1
}

function pending_test_case {
    echo "  NOT IMPLEMENTED"
}

# Compares strings stored in variables `EXPECTED` and `ACTUAL`
function expect_condition {
    local condition="$@"
    echo "testing condition -->" $condition
    if eval $condition; then
        return 0
    else
        $EXIT_ON_FAILURE && fail_test_case || return 1
    fi
}

function expect_true {
    expect_condition "[ $@ ]"
}

function expect_false {
    expect_condition "! [ $@ ]"
}