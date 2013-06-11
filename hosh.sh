#!/bin/sh
# use `set -x` to debug the script
#set -x # use a flag '-d' to enable debuggin

# setup the environment
export HOSH_ARGV="${HOSH_ARGV:-$@}"
export HOSH_DIR="${HOSH_DIR:-$( (readlink $0 || echo $0) | xargs dirname)}" # dirname_real
export HOSH_LIBDIR="${HOSH_LIBDIR:-$HOSH_DIR/lib}"
export HOSH_HOME="${HOSH_HOME:-$HOME/.hosh}"
export HOSH_HOME_LIBDIR="${HOSH_HOME_LIBDIR:-$HOSH_HOME/lib}"
export HOSH_HOME_MODULES="${HOSH_HOME_MODULES:-$HOSH_HOME/modules}"

. $HOSH_LIBDIR/*_init.sh
log_debug "Environment"
env | grep HOSH

# Run a hosh module
# $1: file path of the module to run
run_module() {

    local libdir_content=`files_content_stripped  $HOSH_LIBDIR_FILES`
    local home_libdir_content=`files_content_stripped $HOSH_HOME_LIBDIR_FILES`

    local module_file="$1"
    local module_content=`files_content_stripped $module_file`

    echo $1
    . $module_file

    call_function_if_exists 'before_remote_do'

    # call the modules's `run` function on the remote host
    if function_exists 'remote_do'; then
    REMOTE=${REMOTE:-$HOSH_REMOTE}
    if [ -z "$REMOTE" ]; then
        log_error 'Remote host is undefined. Use $HOSH_REMOTE environment variable.'
        exit 1
    fi
log_debug "CONNECT to $REMOTE"
ssh $REMOTE <<EOF
    ARGV="$HOSH_ARGV"
    ${libdir_content}
    log_debug "CONNECTED to $REMOTE"
    ${home_libdir_content}
    ${module_content}
    log "# -- remote_do --"
    remote_do
EOF
    else
        log_debug 'function `remote_do` undefined'
    fi

    # call the module's `post_run` function
    call_function_if_exists 'after_remote_do'
}

# Run test files
# $1: the test files to run (GLOB pattern)
run_tests() {
    load_libdir
    load_files $HOSH_DIR/test/base.sh
    local testfiles="$(ls $1)"
    echo "-- test files:"
    echo "$testfiles"

    for testfile in $testfiles; do
      echo; echo "file: $testfile"
      echo "-----------------------"
      . $testfile
    done
}

case "$1" in
    test)
        default_if_blank "${2}" "$HOSH_DIR/test/test_*.sh"
        run_tests "$RET"
    ;;
    module|mod)
        case "$2" in
            /*)
                load_libdir
                run_module $2
            ;;
            *)
                load_libdir
                load_home_libdir
                run_module $HOSH_HOME_MODULES/$2
            ;;
        esac
    ;;
    *)
        echo "No such command: \`$@\`" >&2
        exit 1
    ;;
esac