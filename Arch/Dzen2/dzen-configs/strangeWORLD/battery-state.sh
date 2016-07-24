#/bin/bash

FG='#dcdcdc'
BG='#333333'

font1='Inconsolata:size=11'

color2="^fg(#ffeb87)"
color3="^fg(#d78787)"

state=$(acpi | awk '{print $3}' | tr -d ',')
full_state=$(acpi | awk '{print $3}')
# Full, Charging or Discharging
percentage=$(acpi | awk '{print $4}' | tr -d ',')
rem_time=$(acpi | awk '{print $5, $6, $7}')
# remaining time

if [[ "$state" = "Full" ]]
	then
	color="#afffaf"
	info="$full_state $percentage"
elif [[ "$state" = "Charging" ]]
	then
	color="#ffeb87"
	info="$full_state $percentage"
	info1="$rem_time"
else
	color="#d78787"
	info="$full_state $percentage"
	info1="$rem_time"
fi


(

echo "
^p(+60)^fg($color)^fn(Inconsolata:bold:size=11)Battery State^fg()^p()"
echo ""
echo "   ^fg($color)$info^fg()"
echo "   $info1^fg()"
) | dzen2 -p -x 1125 -y 28 -w 208 -bg $BG -fg $FG -l 5 -sa l -ta c -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $font1

