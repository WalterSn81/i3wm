#!/bin/sh
cpu_load=$(top -n | awk '/CPU:/ {print $3}' | tr -d '%')
echo "${cpu_load}"

