#!/bin/zsh

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_brightness {
    light
}

function send_notification {	
    brightness=`get_brightness`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character  ━
    bar=$(seq -s "━" $(($brightness / 5)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i ~/.icons/dunst-icons/brightness.svg -t 1000 -r 2593 -u normal "  $bar"
	
}

case $1 in
    up)
	light -A 5
    send_notification up
	;;
    down)
    light -U 5
	send_notification down
	;;
esac