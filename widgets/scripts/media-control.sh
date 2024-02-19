#!/bin/env bash

get-song-title() {
    local status="$(playerctl status)"

    [[ $status == 'Playing' || $status == 'Paused' ]] &&
	echo -e "$(playerctl metadata title)" || echo -e "nothing..." 
}

get-song-cover() {
    local status="$(playerctl status)"

    [[ $status == 'Playing' || $status == 'Paused' ]] && {
	curl $(playerctl metadata mpris:artUrl) --output ~/.config/eww/assets/cover.png &>/dev/null;
	echo -e "background-image: url('./assets/cover.png');"
    } || {
	echo -e "background-image: url('./assets/no-music.png');"
    }
}

get-song-artist() {
    local status="$(playerctl status)"

    [[ $status == 'Playing' || $status == 'Paused' ]] &&
	echo -e "$(playerctl metadata artist)" || echo -e " " 
}

case $1 in
    "title") get-song-title;;
    "cover") get-song-cover;;
    "artist") get-song-artist;;
    *) echo "invalid command!";;
esac
