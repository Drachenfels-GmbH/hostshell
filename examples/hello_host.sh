REMOTE="redmine2"

hello() { echo "Hello I'm $(uname -a)"; }

before_remote_do() { hello; }
remote_do() { hello; }
after_remote_do() { hello; }
