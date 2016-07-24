#!/bin/sh
if [[ -n "$(mpc current)" ]]; then
	np=$(mpc current)
else
	np="Music off"
fi
echo "$np"
