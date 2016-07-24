#!/usr/bin/env bash

################################
# Shows info about the weather (in Cincinnati) from accuweather.com
#
# TODO: completely rewrite, probably using openweather APIs
# TODO: make location configurable
# TODO: make temperature unit configurable
#
# @return {Number(degrees Fahrenheit)}: Current temperature in Cincinnati
################################

dir=$(dirname $0)
source $dir/util.sh

full=""
short=""
color=""
status=0


URL='http://www.accuweather.com/en/br/uberlandia/33809/weather-forecast/33809'
SITE="$(curl -s "$URL")"

weather="$(echo "$SITE" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $14 }'| head -1)"
temp="$(echo "$SITE" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $12"°" }'| head -1)"


if [[ $weather == *thunder* || $weather == *Thunder* ]]; then
    icon='\ue040'
else
    if [[ $weather == *rain* || $weather == *Rain* ]]; then
        icon='\ue22c' 
    else
        if [[ $weather == *cloud* || $weather == *Cloud* ]]; then
            icon='\ue22b' 
        else
            icon='\ue234' 
        fi
    fi
fi


full="$icon $temp"
#short="$temp"


echo $full
#echo $short
echo $color
exit $status

