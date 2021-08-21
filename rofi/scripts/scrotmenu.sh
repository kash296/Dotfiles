#!/bin/bash

rofi_command="rofi -theme themes/scrotmenu.rasi"

### Options ###
screen="  "
area="  "
window="  "
# Variable passed to rofi
options="$screen\n$area\n$window"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
case $chosen in
    $screen)
        dunstify -i ~/.icons/dunst-icons/image.svg "    Screenshot Taken" && scrot -d 5 -e 'mv $f ~/Pictures/Screenshots 2>/dev/null'
        ;;
    $area)
        scrot -s -e 'mv $f ~/Pictures/Screenshots 2>/dev/null' && dunstify -i ~/.icons/dunst-icons/image.svg "    Screenshot Taken"
        ;;
    $window)
        sleep 1; scrot -u -e 'mv $f ~/Pictures/Screenshots 2>/dev/null' && dunstify -i ~/.icons/dunst-icons/image.svg "    Screenshot Taken"
        ;;
esac

