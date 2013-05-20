# Slices the given string. Uses spaces as separator.
# $1: range (see `man 5 cut`)
# $2: input string
slice_string() {
    local str=$(cut -d ' ' -f2- <<< $@)
    RET=$(cut -d ' ' -f$1 <<< $str)
}
# $1 separator
# $2 the string
# $RET: the number of words
# return: the number of words
word_count() {
     slice_string 1- $@
     RET=$(tr '/' ' ' <<< $RET | wc -w)
     return $RET
}

# KEEP THE NEWLINE
