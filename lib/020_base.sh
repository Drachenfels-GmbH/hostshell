# Defines a variable from heredoc input.
#  $1: variable name
define() {
    read -r -d ';' ${1} || true
}

# Checks if a function exists
# $1: the function name
function_exists() {
    type $1 2>/dev/null | grep -q 'function'
}

# Calls a function if it exists
# $@: function with parameters
call_function_if_exists() {
    if function_exists $1; then
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
copy_return() {
    slice_string 2- $@
    log_debug "Assign value of \$RET to \$$1 after executing: \`${RET}\`"
    $RET
    eval $1=\"$RET\"
}

# Create a symlink for a binary
# $1: the binary
# $2: the path to the symlink
link_binary() {
    local binary_path=$(which $1)
    if [ -z "$binary_path" ]; then
        echo "Binary does not exist"
        return 1
    fi
    if [ -e $2 ]; then
       if [ -L $2 ]  && [ "$(readlink $2)" == "$binary_path" ]; then
            log_debug "Symlink already exists: $2 -> $binary_path"
        else
            log_debug "Failed to create symlink: $2 -> $binary_path"
        fi
        return 1
    else
        log_debug "Creating symlink: $2 -> $binary_path"
        ln -s $binary_path $2
    fi
}

# KEEP THE NEWLINE
