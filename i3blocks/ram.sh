#!/bin/sh

pagesize=$(sysctl -n hw.pagesize)
mem_total=$(sysctl -n hw.physmem)
mem_free=$(sysctl -n vm.stats.vm.v_free_count)
mem_used=$((mem_total - (mem_free * pagesize)))

used_mb=$((mem_used / 1024 / 1024))
total_mb=$((mem_total / 1024 / 1024))
percent=$((used_mb * 100 / total_mb))

warningUsed=90
alertUsed=95
symbol="  "

if [ "$percent" -gt "$alertUsed" ];then
	resultColor="#ffde59"
elif [ $percent -gt $warningUsed ];then
	resultColor="#ffde59"
else
	resultColor="#000000"
fi

echo "<span color=\"$resultColor\">$symbol</span>${percent}% "
echo
