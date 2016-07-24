#!/bin/sh
fg="#fcfcfc"
bg="#2d2d2d"
conky -c ~/.xmonad/scripts/dzenconky_2 | dzen2 -p -ta r -e 'button3=' -fn 'Exo 2-8' -fg "$fg" -bg "$bg" -h 24 -w 650 -x 720 -y 768
