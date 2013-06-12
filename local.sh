before_remote_do() {
    `slice_string 2- $HOSH_ARGV`
}

# View/Search/Modify a hosh method. Displays a select menu if more
# than one function was found for the given search expression (grep simple expression)
# $1: the name/part of the method name to search
help() {
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