#!/bin/sh
temp=$(sysctl -a | grep temperatur | cut -c 34-38)
echo "$temp"
