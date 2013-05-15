#!/bin/bash

HELPER_FILE="$(dirname $0)/helper.sh"
MODULE_FILE="$1"
ARGV=$@

HELPER_CONTENT=`cat ${HELPER_FILE}`
MODULE_CONTENT=`cat ${MODULE_FILE}`

. $HELPER_FILE
. $MODULE_FILE

# call the module's `initialize` function
log "# -- INITIALIZE --"
initialize

# call the modules's `run` function on the remote host
ssh $REMOTE <<EOF
    ${HELPER_CONTENT}
    ${MODULE_CONTENT}

    ARGV=$ARGV

    log "# -- RUN --"
    run
EOF

# call the module's `post_run` function
log "# -- POST RUN --"
post_run
