#!/bin/env bash

# Generate an eww literal to dynamically update workspace location an occuptation 

get-workspace-status() {
    wmctrl -d | awk '{ print $1 " " $2 }'
}

get-current-workspace() {
    get-workspace-status | while read -r id status; do
	[[ $status == '*' ]]            && active_class="active"   || active_class="inactive"
	[[ $active_class == "active" ]] && button_name="󰡱"         || button_name="󰫧"

	echo -n "(button :class \"workspace-button\" :onclick \"wmctrl -s $ID\" \"$button_name\")"
    done
}

echo -e "(box :orientation \"v\"\
	      :class \"workspace-box\"\
	      :space-evenly false :spacing 15\
	      $(get-current-workspace))"
