t_word_count() {
    word_count ' ' "this is the string"
    expect_true "$RET -eq 4"
}

run_test_case t_word_count