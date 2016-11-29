#!/bin/bash 
while true; do 

	if [[ time -eq 25 ]]; then
		mplayer -really-quiet /usr/share/sounds/gnome/default/alerts/glass.ogg
		notify-send "Back to work!"
		cp default.action_block /etc/privoxy/default.action
		let time=5
		service privoxy restart
		for i in $(seq 1 100); do 
			sleep 15
			echo $i
			mins_rem="$(echo "(1500-(15*$i)) / 60 " | bc )"
			secs_rem="$(echo "(1500-(15*$i)) % 60 " | bc )" 
			echo "# $mins_rem:$secs_rem work remaining"
		done | zenity --auto-close --progress --no-cancel --text="You are working"
	else 
		notify-send "Take a break!"
		mplayer -really-quiet /usr/share/sounds/gnome/default/alerts/glass.ogg
		cp default.action_noblock /etc/privoxy/default.action
		service privoxy restart
		let time=25
		for i in $(seq 1 100); do
			sleep 3
			echo $i
			mins_rem="$(echo "(300-(3*$i)) / 60 " | bc )"
			secs_rem="$(echo "(300-(3*$i)) % 60 " | bc )" 
			echo "# $mins_rem:$secs_rem break remaining" 
		done | zenity --progress --auto-close --no-cancel --text="You are on a break"
	fi
done 
