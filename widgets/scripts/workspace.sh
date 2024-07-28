#!/bin/env bash

get_workspaces() {
    wmctrl -d | awk '{ print $1 " " $2 }' 
}

gen_workspaces() {
    buffered=""

    get_workspaces | while read -r id active; do
	if [[ "$active" == "*" ]]; then
	    active_class="  "
	else
	    active_class="  "
	fi

	# if wmctrl -l | grep --regexp '.*\s\+'"$id"'\s\+.*' >/dev/null; then
	#     occupation_class="occupied"
	# else
	#     occupation_class="empty"
	# fi

	buffered+="$active_class"

	echo -n "$buffered"
	buffered=""
    done
}

echo "$(gen_workspaces)"
