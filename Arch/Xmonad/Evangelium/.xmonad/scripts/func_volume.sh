#!/bin/sh
bar_bg="#2d2d2d"
bar_fg="#ffffff"
AMASTER=`amixer get Master | awk 'END{gsub(/\[|\]|%/,""); print $4}'`
ASTAT=`amixer get Master | awk 'END{gsub(/\[|\]|%/,""); print $6}'`

if [[ $ASTAT = "on" ]]; then
    PERCBAR=`echo "$AMASTER"\
        | gdbar -bg $bar_bg -fg $bar_fg -h 3 -w 60`
else
    PERCBAR=`echo 0 \
        | gdbar -bg $bar_bg -fg $bar_fg -h 3 -w 60`
fi

echo "^ca(4,amixer set Master 1%+)^ca(5,amixer set Master 1%-)$PERCBAR^ca()^ca()"
