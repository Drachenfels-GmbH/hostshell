before_remote_do() {
    `slice_string 2- $HOSH_ARGV`
}

# View/Search/Modify a method. Displays a select menu if more
# than one method was found for the given search expression (simple grep expression).
# $1: the expression that matches the method name to search.
hosh_help() {
    local library_files=`ls $HOSH_HOME_LIBDIR/*.sh $HOSH_LIBDIR/*.sh`
    local locations=`grep -n ".*$1.*() \+{" $library_files | cut -d'{' -f 1`
    location=`select_item $locations`

    if [ -z "$location" ]; then
        echo "No matches"
    else
        # see http://vimdoc.sourceforge.net/htmldoc/scroll.html
        vim `echo $location | tr ':' ' ' | awk '{ printf "%s +%s", $1, $2 }'`
    fi
}