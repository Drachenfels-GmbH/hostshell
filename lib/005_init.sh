# Returns the directory name of the given path (after symlink resolution)
# $1: the path
# $RET: the dirname of the path
function dirname_real {
    echo $@
    RET=`(readlink $1 || echo $1) | xargs dirname`
}

# Prints a message to STDOUT, prefixed with the hosts node name.
#  $@: the message
function log {
    echo "[$(uname -n)] $@"
}

# Calls `log` when `DEBUG` is enabled.
# $@: the message
function log_debug {
    $DEBUG && log "DEBUG -- " $@
}

# $1: the value to check
# $2: the default value
# $3: the condition
function default_if_false {
    local condition=$1
    local value=$2
    local default=$3

    log_debug "Set RET to \$default if condition fails:" $condition
    log_debug "\$value='$value' \$default='$default'"
    if eval $condition; then
        RET=$value
        return 0
     else
        RET=$default
        return 1
     fi
}

# $1: the string value to check
# $2: the default value
# $RET: $1 if $1 is not blank else $2
function default_if_blank {
    default_if_false "[ -n '${1}' ]" "$1" "$2"
}

# Load a file
# $1: the filename
function load_file {
    echo "Loading $1"
    . $1
}

# Load library files $HOSH_DIR/lib/*.sh
function load_stdlib {
    STDLIB_FILES="$(ls $HOSH_DIR/lib/*.sh)"
    echo "-- Loading library files:"
    for file in $STDLIB_FILES; do
        load_file $file
    done
}

# KEEP THE NEWLINE