#! /bin/bash


status=$(cat ~/.cache/Forecast.json | jshon -Q -e currently)

if [[ "$status" = "" ]]
	then
	info="^fg(#666666)^fn(Ubuntu:size=10)No Access"
else
	icon=$(grep `cat ~/.cache/Forecast.json | jshon -e currently | jq '.icon' | grep -o '[^\"]*'` ~/Dzen2/dzen-configs/strangeWORLD/weatherIconList | awk 'NR==1' | grep -o "\"[^\"]*\"" | grep -o "[^\"]*")
	temp=$(printf "%0.0f\n" `cat ~/.cache/Forecast.json | jshon -e currently | jq '.temperature'`)
	info="^fn(Weather Icons:size=13)$icon^fn() $temp°C"
fi

echo "$info"