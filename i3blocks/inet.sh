#!/bin/sh

symbol=" "

inet=$(ifconfig wlan0 | awk '/inet / {print $2}')
if [ -z $inet ];then
    color="#cc6ce7"
    inet=" Down"
else
    color="#000000"
fi

echo "<span color=\"$color\">$symbol</span> ${inet} "
