#! /bin/bash

mss_count=$(grep -o '<fullcount>.*</fullcount>' ~/.cache/gmailParsed.xml | sed 's/\(<fullcount>\|<\/fullcount>\)//g')


if [[ "$mss_count" = "" ]]
	then
	icon="^fg(#666666)^fn(FontAwesome:size=13) ^fn() 0^fg()"
elif (( "$mss_count" != 0 ))
	then
	icon="^fg(#d78787)^fn(FontAwesome:size=13) ^fn() $mss_count^fg()"
else
	icon="^fn(FontAwesome:size=13) ^fn() $mss_count^fg()"
fi

echo "$icon"
