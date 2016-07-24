#/bin/bash

status=$(dropbox-cli status)


if [[ "$status" = "Up to date" ]]
	then
	icon="^fg(#87d7ff)^fn(Ionicons:size=18)^fn()^fg()"
else
	icon="^fg(#ffeb87)^fn(Ionicons:size=18)^fn()^fg()"
fi

echo "  $icon  "