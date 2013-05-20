# -- RUBY GEMS --

# Checks if a ruby gem is installed.
# $1: name of the gem package
# return: 0 if the package is installed, 1 if not
function gem_installed {
    gem list -i $1 > /dev/null
}

# $RET: the directory for executables installed by `gem`.
function gem_bindir {
    RET="$(gem environment | grep "EXECUTABLE DIRECTORY" | cut -d ':' -f 2 | tr -d ' ')"
}

# KEEP THE NEWLINE
