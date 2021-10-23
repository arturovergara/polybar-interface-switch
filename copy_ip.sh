#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/polybar/scripts/interface.conf"

main()
{
	# Check if config file exists
	[ -e $CONFIG_FILE ] || exit -1

	interface=$(grep -w 'interface:' $CONFIG_FILE | cut -d ' ' -f2)

	# Check if config file has right format
	[ -n "$interface" ] || exit -1

	# Check if the interface specified in config file exists
	[ -L "/sys/class/net/$interface" ] || exit -1

	# Get the IPv4 address
	ip=$(/sbin/ip -o -4 a l $interface | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
	
	# Copy the IPv4 address to clipboard
	[ -n "$ip" ] && echo -n "$ip" | xclip -sel c
}

main "$@"
