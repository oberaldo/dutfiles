#!/bin/sh 

echo "$(sensors coretemp-isa-0000 | awk '/Core 0/ {print $3}')"
