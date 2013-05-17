#!/bin/bash
# append `-x` to bash command to enable debugging or
# use `set -x` from withing the script
shopt -s expand_aliases # allow aliases

ARGV=$@
HOSH_DIR="$( (readlink $0 || echo $0) | xargs dirname)" # dirname_real
. $HOSH_DIR/lib/*_init.sh   # load_file

# Run a hosh module
# $1: file path of the module to run
function run_module {
    load_stdlib
    local stdlib_content=`cat ${STDLIB_FILES}`
    local module_file="$1"
    local module_content=`cat ${module_file}`
    . $module_file

    call_function_if_exists 'initialize'

    # call the modules's `run` function on the remote host
    if function_exists? 'run'; then
ssh $REMOTE <<EOF
    ${stdlib_content}
    ${module_content}
    ARGV=$ARGV

    log "# -- run --"
    run
EOF
    else
        log_debug 'function `run` undefined'
    fi

    # call the module's `post_run` function
    call_function_if_exists 'post_run'
}

# Run test files
# $1: the test files to run (GLOB pattern)
function run_tests {
    load_stdlib
    load_file $HOSH_DIR/test/base.sh
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
    module)
        run_module $2
    ;;
    *)
        echo "No such command: \`$@\`" >&2
        exit 1
    ;;
esac