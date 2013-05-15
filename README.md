# hostshell `hosh`

A simple wrapper for SSH based remote scripting.
Guaranteed 100% pure shell.
The lightweight alternative to puppet, chef ...

<pre>
REMOTE="the-remote-host-name"

function hello { echo "Hello I'm $(uname -a)"; }

function initialize { hello; }
function run { hello; }
function post_run { hello; }
</pre>


Replace the hostname in the `REMOTE` variable and run the example with `./hosh.sh examples/hello_host.sh`

## REMOTE LOGIN 

Use ssh public key authentication to securely automate the remote login.

## GLOBAL VARIABLES 

### `REMOTE` 

The remote hostname supplied to `ssh`

To set host specific options use the ssh configuration file `~/.ssh/config`. See `man 5 ssh_config`.


##  MODULE HOOKS

###  `initialize` 

Executed on the local host after helper library and module are included.

###  `run` 

Executed on the remote host after helper library and module are included.

###  `post_run` 

Executed on the local host after `run`.


##  TODO 

* generate a UUID to identify the script execution
* transfer state from remote execution (simple use a remote file)
* save method return values/errors in global variables (RETURN/ERRNO)
* test if remote host is available (helper method for initialize)