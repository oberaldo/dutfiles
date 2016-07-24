#/bin/bash

FG='#dcdcdc'
BG='#333333'

font1='Inconsolata:size=11'
font2="Meslo LG S DZ:size=9"

status=$(dropbox-cli status)

if [[ "$status" = "Up to date" ]]
	then
	info="$status"
	color="^fg(#87d7ff)"
else
	info1=$(dropbox-cli status | awk 'NR==1')
	info2=$(dropbox-cli status | awk 'NR==2')
	info3=$(dropbox-cli status | awk 'NR==3')
	color="^fg(#ffeb87)"
fi

(

echo "
$color^p(+90)^fn(Inconsolata:bold:size=11)Dropbox Status^p()"
echo ""
echo "   ^fn($font2)$color$info"
echo "   ^fn($font2)$color$info1"
echo "   ^fn($font2)$color$info2"
echo "   ^fn($font2)$color$info3"
) | dzen2 -p -x 1098 -y 28 -w 268 -bg $BG -fg $FG -l 7 -sa l -ta c -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $font1

