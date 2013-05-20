REMOTE="the-remote-host-name"

hello() { echo "Hello I'm $(uname -a)"; }

initialize() { hello; }
run() { hello; }
post_run() { hello; }
