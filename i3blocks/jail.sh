#!/bin/sh

jails=$(jls -n name | cut -d "=" -f 2)
if [ -z $jails ];then
    echo ""
else
    echo "  $(jls -h host.hostname | awk 'NR>1 {print $1}' | paste -sd, -) "
fi
