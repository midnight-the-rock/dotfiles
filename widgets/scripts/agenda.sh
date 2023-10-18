#!/bin/env bash

# generate a scrollable element with all agenda items

agenda_location=$(echo $HOME/Desktop/agenda/*.org)

get-agenda() {
    cat $agenda_location | while read -r line; do 
	[[ $(echo "$line" | grep --regex "^\*") != '' ]] && {
	    no_indent_line=$(echo "$line" | tr -d '*') 
	    item_type=$(echo -e "$no_indent_line" | awk '{ print $1 }')
	    item_data=$(echo -e "$no_indent_line" | cut -d ' ' -f 3-20)

	    [[ $(echo "$line" | grep --regex "^\*\* ") != '' ]] && style_class="agenda_todo" || style_class="agenda_header"

	    [[ $style_class == "agenda_header" ]] && 
		echo "(label :class \"$style_class\" :limit-width 44 :xalign 0.0 :text \"$no_indent_line\")" ||
		    echo "(box :space-evenly false :spacing 10 (label :class \"$style_class\" :limit-width 10 :xalign 0.0 :text \"$item_type\") (label :limit-width 44 :xalign 0.0 :text \"$item_data\"))"  
	}
    done
}

echo -e "(scroll :class \"agenda_scroll\" :vscroll true :hscroll false (box :orientation \"v\" $(get-agenda)))"
