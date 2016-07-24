#! /bin/bash

FG='#dcdcdc'
BG='#333333'

font1='Ubuntu:size=10'
# Count how many new messages are in inbox
mss_count=`grep -o '<fullcount>.*</fullcount>' ~/.cache/gmailParsed.xml | sed 's/\(<fullcount>\|<\/fullcount>\)//g'`

let "line_count=$mss_count + 3"
# Parse the titles of inbox messages
mss_titles=`grep -o '<title>.*</title>' ~/.cache/gmailParsed.xml | awk NR\>1 | sed 's/\(<title>\|<\/title>\)//g' | cut -c-35 | sed 's/$/ .../' | sed 's/^/   \^fn(Ionicons:size=10)^fg(#d78787)^fg(#dcdcdc)^fn(Meslo LG S DZ:size=9) /'`
(

echo "
^p(+115)^fg(#d78787)^fn(Inconsolata:bold:size=11)Gmail Inbox^fg()^p()"
echo ""
echo "$mss_titles"
) | dzen2 -p -x 40 -y 28 -w 308 -bg $BG -fg $FG -l $line_count -sa l -ta c -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $font1





