#/bin/bash

percentage=$(acpi | awk '{print $4}' | tr -d '%' | tr -d ',')
charge=$(acpi | awk '{print $3}' | tr -d ',')
# Full or Discharging

if [[ "$charge" = "Full" ]]
	then
	icon="^fg(#afffaf)^fn(Ionicons:size=16)^fn()"
elif [[ "$charge" = "Charging" ]]
	then
	icon="^fg(#ffeb87)^fn(Ionicons:size=16)^fn()"
elif (("$percentage" < 100)) && (("$percentage" >= 70))
	then
	icon="^fg(#ffeb87)^fn(Ionicons:size=16)^fn()"
elif (("$percentage" < 70)) && (("$percentage" >= 45))
	then
	icon="^fg(#d78787)^fn(Ionicons:size=16)^fn()"
elif (("$percentage" < 45)) && (("$percentage" >= 1))
	then
	icon="^fg(#d78787)^fn(Ionicons:size=16)^fn()"
else
	icon="^fg(#d78787)^fn(Ionicons:size=16)^fn()"
fi

echo "$icon"