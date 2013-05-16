# Defines a variable from heredoc input
#  $1: variable name
function define {
    read -r -d '' ${1} || true
}

# Checks if a function exists
# $1: the function name
function function_exists? {
    type $1 | grep -q 'function'
}

# Calls a function if it exists
function call_function_if_exists {
    if function_exists? $1; then
        log "# -- $1 --"
        local params=$@
        $1 ${params[1]}
    else
        log_debug "function \`$1\` undefined"
    fi
}

# Prints a message to STDOUT, prefixed with the hosts node name.
#  $@: message
function log {
    echo "[$(uname -n)] $@"
}

# calls `log` when `DEBUG` is enabled
function log_debug {
    [ "$DEBUG" == "true" ] && log "DEBUG -- " $@
}

# $1: global variable to copy the value of the global `RET` variable
# $2: function to call (function must set `RET` variable)
# $3-$x: parameters passed to function that is called
function copy_return {
    local params=( $@ )
    log_debug "Copy variable RET to variable $1 after executing \`${params[1]}"
    $2 ${params[2]}
    eval "$1=$RET"
}

# KEEP THE NEWLINE
