#!/bin/sh

bStatus=$(apm -l 2>/dev/null)

yellow=10
red=5

sym=" "

if [ "$bStatus" -le "$red" ];then
	color="#cc6ce7"
elif [ "$bStatus" -le "$yellow" ];then
	color="#ffde59"
else
	color="#000000"
fi

echo "<span color=\"$color\">$sym</span> ${bStatus}% "
echo
