#!/usr/bin/env bash

icon="$HOME/.lock.png"
tmpbg="/tmp/screen.png"

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
#nuvolaplayer3ctl action pause
i3lock  -i "$tmpbg"
