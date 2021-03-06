# hostshell `hosh`

A simple wrapper for SSH based remote scripting.
Guaranteed 100% pure shell.
The lightweight alternative to puppet, chef ...

<pre>
REMOTE="remotehost"

hello() { echo "Hello I'm $(uname -a)"; }

before_remote_do() { hello; }
remote_do() { hello; }
after_remote_do() { hello; }
</pre>


Replace the hostname in the `REMOTE` variable and run the example with `./hosh.sh examples/hello_host.sh`

## REMOTE LOGIN 

Use ssh public key authentication to securely automate the remote login.

## GLOBAL VARIABLES 

### `REMOTE` 

The remote hostname supplied to `ssh`

To set host specific options use the ssh configuration file `~/.ssh/config`. See `man 5 ssh_config`.


##  MODULE HOOKS

###  `before_remote_do`

Executed on the local host after helper library and module are included.

###  `remote_do`

Executed on the remote host after helper library and module are included.

###  `after_remote_do`

Executed on the local host after `remote_do`.


## CONTRIBUTE

### LIBRARY CONVENTIONS


* document function parameters
* write posix compliance functions
* keep functions small
* validate / document posix compliant of functions

#### FUNCTION DOCUMENTATION

* description
* method parameters
* return value
* altered global variables

#### LIBRARIES

* library file must have a trailing newline (`line xx: syntax error: unexpected end of file`)
*
* natural order of library files must reflect dependencies
* dependent functions should always be declared before using them (although this is not required)

#### NAMING

* external commands must not be overwritten by functions (add guard to check if command is defined)
* `test_` is the reserved prefix for test functions

## POSIX COMPLIANCE

really hard stuff

* try bashcritic from https://trac.id.ethz.ch/projects/bashcritic/
* http://www.spinics.net/lists/dash/msg00537.html

## list all methods

`grep -o --no-filename 'function .* {$' lib/* | sort | cut -d ' ' -f2`

##  TODO 

* transfer state from remote execution (simple use a remote file)
* save method return values/errors in global variables (RETURN/ERRNO)
* test if remote host is available (helper method for initialize)
* check/extract CLI arguments using getopt
* test remote shell compliance
* generate nice looking API documentation in markup (evaluate function documentation)
* colorize output if available using `tput` http://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/
* make hosh embeddable into ordinary shell scripts to launch the scripts directly
* don't use global variables: http://www.linuxjournal.com/content/return-values-bash-functions

## IDEAS

* generate a UUID to identify the script execution ?
* add bash completion for functions ?