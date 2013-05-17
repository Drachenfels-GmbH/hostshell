# TODO prevent SSH host key verification failure !
# Forces a git repository to be up-to date to its tracked master.
# The repository is cloned if it does not exist.
#  $1: remote url
#  $2: destination folder
function git_sync {
    local remote=$1
    local destination=$2

    log "Syncing repository $remote to $destination"

    if [ -d $destination ]; then
        cd $destination
        git fetch
        git add -A
        git reset --hard origin/master

    else
        git clone $remote $destination
    fi
}

# KEEP THE NEWLINE
