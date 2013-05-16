# Defines a variable from heredoc input.
#  $1: variable name
function define {
    read -r -d '' ${1} || true
}

# Checks if a function exists
# $1: the function name
function function_exists? {
    type $1 2>/dev/null | grep -q 'function'
}

# Slices the given string. Uses spaces as separator.
# $1: range (see `man 5 cut`)
# $2: input string
function slice_string {
  local str=$(cut -d ' ' -f2- <<< $@)
  RET=$(cut -d ' ' -f$1 <<< $str)
}

# Calls a function if it exists
# $@: function with parameters
function call_function_if_exists {
    if function_exists? $1; then
        log "# -- $1 --"
        $@
    else
        log "function \`$1\` is undefined"
    fi
}

# Prints a message to STDOUT, prefixed with the hosts node name.
#  $@: the message
function log {
    echo "[$(uname -n)] $@"
}

# Calls `log` when `DEBUG` is enabled.
# $@: the message
function log_debug {
    [ "$DEBUG" == "true" ] && log "DEBUG -- " $@
}

# Executes function an copies the functions result from `RET` into another variable.
# $1: name of the global variable where `RET` from function is copied to
# $2-: function with parameters (function must set the `RET` variable)
# $RET: `RET` value of the executed function
function copy_return {
    slice_string 2- $@
    log_debug "Assign value of \$RET to \$$1 after executing: \`${RET}\`"
    $RET
    eval $1=\"$RET\"
}

# KEEP THE NEWLINE
