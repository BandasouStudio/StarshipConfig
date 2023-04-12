#!/bin/bash
# shellcheck disable=SC2016

set_logo() {
	logo_style="[ $1](fg:$2 bg:white)"
}

set_logo_with_bg() {
	logo_style="[ $1 ](fg:$2 bg:$3)"
}

output_common_config() {
	cat common.toml
	echo
}

output_username_config() {
	cat username.toml
	echo "format = \"${logo_style}[ \$user ](fg:black bg:white)\""
	echo
}

output_status_config() {
	cat status.toml
	if [ "$(uname -o)" == Msys ]; then
		cat status.windows.toml
	else
		cat status.unix.toml
	fi
	echo
}

if [ "$(uname -s)" == Linux ]; then
	if [ -f /usr/bin/pveversion ]; then
		set_logo_with_bg "PROXMOX" "bright-white" "yellow bold"
	elif [ -f /proc/syno_platform ]; then
		set_logo_with_bg "DSM" "bright-white" "bright-blue bold"
	elif [ -f /etc/os-release ]; then
		id=$(grep -E '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
		case $id in
			"arch")
				set_logo "" "blue";;
			"manjaro")
				set_logo "" "green";;
			"debian")
				set_logo "" "red";;
			*)
				set_logo "" "yellow";;
		esac
	else
		set_logo "" "yellow"
	fi
elif [ "$(uname -s)" == Darwin ]; then
	set_logo "" "black"
elif [ "$(uname -o)" == Msys ]; then
	set_logo "" "blue"
fi

output_common_config
output_status_config
output_username_config
