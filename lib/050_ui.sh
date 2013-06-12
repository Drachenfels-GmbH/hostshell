# Create a select menu from the given items
# $@: list of items, separated by space or newline
# stdout: the selected item
# stderr: the select menu and question
select_item() {
    count=0
    matches=0
    local items="$@"
    [ -n "$items" ] && matches=`echo "$items" | wc -w`

    if [ $matches -eq 1 ]; then
        echo $@
    elif [ $matches -gt 1 ]; then
        for item in $items; do
            echo "$count) $item" >&2
            ((count++))
        done

        # stdout is captured so we have to use stderr for output
        echo "Enter number to select: " | tr -d '\n' >&2
        read selected

        count=0
        for item in $items; do
            if [ $count -eq $selected ]; then
                echo $item
            fi
            ((count++))
        done
    else
        echo ""
    fi
}

# KEEP THE NEWLINE
