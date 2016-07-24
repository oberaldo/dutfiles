#/bin/bash

FG='#dcdcdc'
BG='#333333'

font1='Ubuntu:size=10'
 #A simple popup showing system information
count=$(checkupdates | wc -l)
let "line_count=$count + 1"

( 
 echo "" # Fist line goes to title
 # The following lines go to slave window
 checkupdates | sed 's/^/   \^fn(Ionicons:size=10)^fg(#beffbe)^fg(#dcdcdc)^fn(Meslo LG S DZ:size=9) /'
 
) | dzen2 -p -x "40" -y "28" -w "250" -bg $BG -fg $FG -l "$line_count" -sa 'l' -ta 'c' -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $font1
 # "onstart=uncollapse" ensures that slave window is visible from start.