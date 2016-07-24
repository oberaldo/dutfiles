#!/bin/sh

echo -e "`free -mh | awk '/^Mem/ {print $3}'`"
