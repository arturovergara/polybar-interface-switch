#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/polybar/scripts/interface.conf"

print_error()
{
	echo -e "%{F#FA3935} %{F#F1F1F1} $1"
	exit -1
}

main()
{
	# Check if config file exists
	[ -e $CONFIG_FILE ] || print_error "Config file does not exist."

	# Get interface from config file
	interface=$(grep -w 'interface:' $CONFIG_FILE | cut -d ' ' -f2)

	# Check if config file has right format
	[ -n "$interface" ] || print_error "Wrong config file format."

	# Check if the interface specified in config file exists
	[ -L "/sys/class/net/$interface" ] || print_error "Interface in config file does not exist."

	if [[ $interface =~ "docker" ]]; then
		icon="%{F#2496ED}"
	elif [[ $interface =~ "tun" ]]; then
		icon="%{F#9FEF00}"
	else
		icon="%{F#2CA2F5}"
	fi

	# Get the IPv4 address
	ip=$(/sbin/ip -o -4 a l $interface | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)

	# Print the IPv4 addres if was found
	if [ -n "$ip" ]; then
		echo -e "$icon %{F#F1F1F1}$ip%{u-}"
	else
		print_error "IPv4 address not found."
	fi
}

main "$@"
