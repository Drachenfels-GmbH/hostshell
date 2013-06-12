# Slices the given string. Uses spaces as separator.
# $1: range (see `man 5 cut`)
# $2: input string
slice_string() {
    local str=$(echo $@ | cut -d ' ' -f2- )
    RET=$(echo $str | cut -d ' ' -f$1)
    echo $RET
}
# $1 separator
# $2 the string
# $RET: the number of words
# return: the number of words
word_count() {
     slice_string 1- $@
     RET=$(echo $RET | tr '/' ' ' | wc -w)
     return $RET
}

# KEEP THE NEWLINE
