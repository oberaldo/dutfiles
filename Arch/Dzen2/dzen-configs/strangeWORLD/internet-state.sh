#! /bin/bash

FG='#dcdcdc'
BG='#333333'

fn1="Inconsolata:size=11"
fnT="Inconsolata:bold:size=11"

wifiState=$(cat /sys/class/net/wlp3s0/operstate)
ethernetState=$(cat /sys/class/net/enp3s0/operstate)

connectionState=$(ping -q -c 3 www.google.com | grep loss | awk '{print $6,$7,$8}' | tr -d ',')

percentage=$(echo $connectionState | awk '{print $1}' | tr -d '%')


if [[ "$percentage" = "0" ]]
	then
	color="#afffaf"
else
	color="#d78787"
fi	

if [[ "$connectionState" = "" ]]
	then
	connectionState="No access"
else
	connectionStat="$connectionState"
fi

(
echo "
^p(+25)^fn($fnT)Internet connection state"
echo "    ^fg($color)^fn($fn1)$connectionState"
) | dzen2 -p -x 1098 -y 28 -w 235 -bg $BG -fg $FG -l 3 -sa l -ta c -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $fn1
