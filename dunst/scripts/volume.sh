#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification() {	
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character  ━
    bar=$(seq -s "━" $(($volume / 5)) | sed 's/[0-9]//g')
    # Send the notification

	if [[ $1 = 'up' ]] ; then
	    dunstify -i ~/.icons/dunst-icons/volume-up.svg -t 1000 -r 2593 -u normal "  $bar"
	elif [[ $1 = 'down' ]] ; then
	    dunstify -i ~/.icons/dunst-icons/volume-down.svg -t 1000 -r 2593 -u normal "  $bar"
	else
		dunstify -i ~/.icons/dunst-icons/volume.svg -t 1000 -r 2593 -u normal "  $bar"
	fi


}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 1%+ > /dev/null
	send_notification up
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 1%- > /dev/null
	send_notification down
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
	    dunstify -i ~/.icons/dunst-icons/volume-slash.svg -t 1000 -r 2593 -u normal "Mute"
	else
	    send_notification volume
	fi
	;;
esac