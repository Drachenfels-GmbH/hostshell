REMOTE="the-remote-host-name"

function hello { echo "Hello I'm $(uname -a)"; }

function initialize { hello; }
function run { hello; }
function post_run { hello; }
