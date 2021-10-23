#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/scripts"
CONFIG_FILE="$SDIR/interface.conf"
STYLES_FILE="$SDIR/interface.rasi"

main()
{
	# Get list of interfaces available
	for i in $(/sbin/ip l | grep -E "^[[:digit:]]:" | cut -d ':' -f2 | grep -v "lo"); do

		if [[ $i =~ "docker" ]]; then
			icon=""
		elif [[ $i =~ "tun" ]]; then
			icon=""
		else
			icon=""
		fi

		options+="$icon $i|"
	done

	# Launch rofi to catch the interface
	interface=$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' -theme $STYLES_FILE <<< "${options::-1}")

	# Check if an interface was specified
	[ -n "$interface" ] && echo -e "interface: ${interface##* }" > $CONFIG_FILE
}

main "$@"
