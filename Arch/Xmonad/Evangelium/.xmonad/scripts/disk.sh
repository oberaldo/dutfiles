#!/bin/sh

echo `df -h | grep "/$" | awk -F' ' '{ print $5 }'`
