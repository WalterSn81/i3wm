#!/bin/sh

ss=$(ifconfig wlan0 | awk '/inet / {print $2}')

if [ -z $ss ];then
    echo "No Carria"
else
    echo "$ss"
fi

