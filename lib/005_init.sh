# Returns the directory name of the given path (after symlink resolution)
# $1: the path
# $RET: the dirname of the path
dirname_real() {
    echo $@
    RET=`(readlink $1 || echo $1) | xargs dirname`
}

# Prints a message to STDOUT, prefixed with the hosts node name.
#  $@: the message
log() {
    echo "[$(uname -n)] $@"
}

# Prints a message to STDOUT, prefixed with the hosts node name.
#  $@: the message
log_error() {
    echo "[$(uname -n)] $@" >&2
}

# Calls `log` when `DEBUG` is enabled.
# $@: the message
log_debug() {
    $DEBUG && log "DEBUG -- " $@
}

# $1: the value to check
# $2: the default value
# $3: the condition
default_if_false() {
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
default_if_blank() {
    default_if_false "[ -n '${1}' ]" "$1" "$2"
}

files_exist() {
    if [ $# -gt 0 ] && ls $@ >/dev/null; then
        return 0
    else
        return 1
    fi
}
# Loads files
# $@: the files to load
load_files() {
    for file in $@; do
        log_debug "Loading $file"
        . $file
    done
}

# Load stdlib files $HOSH_HOME_LIBDIR/lib/*.sh
load_libdir() {
    log_debug 'Loading library files from $HOSH_LIBDIR:'
    HOSH_LIBDIR_FILES="$(ls $HOSH_LIBDIR/*.sh)"
    load_files $HOSH_LIBDIR_FILES
}

# Load userlib files from $HOME/.hosh/lib
load_home_libdir() {
    log_debug 'Loading library files from $HOSH_HOME_LIBDIR:'
    if files_exist $HOSH_HOME_LIBDIR/*.sh; then
        HOSH_HOME_LIBDIR_FILES="$(ls $HOSH_HOME_LIBDIR/*.sh)"
        load_files $HOSH_HOME_LIBDIR_FILES
    fi
}

# Print content of files to stdout (excluding lines commented with a hash)
# $@: files to strip and print
files_content_stripped() {
    if files_exist $@; then
        cat $@ 2>/dev/null | grep -v '^\s*#'
        return 0
    else
        return 1
    fi
}

# KEEP THE NEWLINE
