#!/bin/sh

cur=`mpc current`
test -n "$cur" && echo $cur || echo "- stopped -"