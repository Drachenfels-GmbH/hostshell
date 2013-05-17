# Defines a variable from heredoc input.
#  $1: variable name
function define {
    read -r -d ';' ${1} || true
}

# Checks if a function exists
# $1: the function name
function function_exists? {
    type $1 2>/dev/null | grep -q 'function'
}

# Calls a function if it exists
# $@: function with parameters
function call_function_if_exists {
    if function_exists? $1; then
        log "-- calling function: $1 --"
        $@
    else
        log "function \`$1\` is undefined"
    fi
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


# $1: the session name
function run_in_tmux {
    local session=$1
    local window=$2
    slice_string 3- $@
    define 'IN'
    tmux attach -t $session 2>/dev/null || tmux new-session -d -s $session -n $window
    tmux send-keys -t${session}:0 \'$code\' C-m
}

# KEEP THE NEWLINE