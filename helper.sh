# Defines a variable from heredoc input
#  $1: variable name
function define {
    read -r -d '' ${1} || true
}

# Prints a message to STDOUT, prefixed with the hosts node name.
#  $1: message
function log {
    echo "[$(uname -n)] $1"
}

# Forces a git repository to be up-to date its tracked master.
# The repository is cloned if it does not exist.
#  $1: remote url
#  $2: destination folder
function git_sync {
    local remote=$1
    local destination=$2

    cd $destination
    if [ -d $destination ]; then
        cd $destination
        git fetch
        git add -A
        git reset --hard origin/master

    else
        git clone $remote $destination
    fi
}