function t_dirname_real {
    local suffix=$(date +%s)
    local folder="/tmp/foobar-${suffix}"
    mkdir $folder
    ln -s $folder ${folder}.symlink
    dirname_real ${folder}.symlink
    expect_return "= /tmp"
}

function t_log {
    pending_test_case
}

function t_log_debug {
    pending_test_case
}

function t_default_if_false {
    pending_test_case
}

function t_default_if_blank {
    pending_test_case
}

function t_load_file {
    pending_test_case
}

function t_load_stdlib {
    pending_test_case
}

run_test_case t_dirname_real
run_test_case t_log
run_test_case t_log_debug
run_test_case t_default_if_false
run_test_case t_default_if_blank
run_test_case t_load_file
run_test_case t_load_stdlib