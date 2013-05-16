#!/bin/bash
shopt -s expand_aliases # allow aliases

HOSH_DIR="$(readlink $0 | xargs dirname)"
STDLIB_FILES="$(ls $HOSH_DIR/lib/*.sh)"
MODULE_FILE="$1"
ARGV=$@

STDLIB_CONTENT=`cat ${STDLIB_FILES}`
MODULE_CONTENT=`cat ${MODULE_FILE}`

. $STDLIB_FILES
. $MODULE_FILE

call_function_if_exists 'initialize'

# call the modules's `run` function on the remote host
if function_exists? 'run'; then
ssh $REMOTE <<EOF
    ${STDLIB_CONTENT}
    ${MODULE_CONTENT}
    ARGV=$ARGV

    log "# -- run --"
    run
EOF
else
    log_debug 'function `run` undefined'
fi

# call the module's `post_run` function
call_function_if_exists 'post_run'
