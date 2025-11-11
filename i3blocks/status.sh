#!/bin/sh

alertColor="#cc6ce7"
warningColor="#ffde59"
VPNColor="#008a02"
normalColor="#000000"



msgString=""

akkuSymbol=""
ramSymbol=""
volumeSymbol=""
inetSymbol=""
calendarSymbol=""
vpnSymbol=""
jailSymbol=""

makeString(){
    if [ -z $3 ];then
        msgString="<span color=\"$1\"> $2 </span>$3"
    else
        msgString="<span color=\"$1\"> $2 </span>$3 "
    fi
}

getJailStatus(){
    jail=$(jls -n name | cut -d "=" -f 2)
    if [ -z $jail ];then
        return
    else
        msg="$(jls -h host.hostname | awk 'NR>1 {print $1}' | paste -sd, -)"
        makeString "$normalColor" "$jailSymbol" "$msg"
    fi
}

getVPN(){
    stat=$(ifconfig | grep wg)
    if [ -z "$stat" ];then
        return
    else
        makeString "$VPNColor" "$vpnSymbol"
    fi
}

getDate(){
    data=$(date '+%d.%m.%Y  %H:%M')
    makeString "$normalColor" "$calendarSymbol" "$data"
}

getInetStatus(){
    interface="wlan0"
    inetStat=$(ifconfig $interface | awk '/inet / {print $2}')
    if [ -z $inetStat ];then
        tmpColor=$warningColor
        inetStat="Down"
    else
        tmpColor=$normalColor
    fi

    makeString "$tmpColor" "$inetSymbol" "$inetStat"
}

getVolumeStatus(){
    vol=$(mixer vol | cut -c 14-15)
    makeString "$normalColor" "$volumeSymbol" "$vol%"
}

getRamStatus(){
    alertLimit=95
    warningLimit=90

    pagesize=$(sysctl -n hw.pagesize)
    mem_total=$(sysctl -n hw.physmem)
    mem_free=$(sysctl -n vm.stats.vm.v_free_count)
    mem_used=$((mem_total - (mem_free * pagesize)))
    used_mb=$((mem_used / 1024 / 1024))
    total_mb=$((mem_total / 1024 / 1024))
    percent=$((used_mb * 100 / total_mb))

    if [ "$percent" -gt "$alertLimit" ];then
        tmpColor=$alertColor
    elif [ "$percent" -gt "$warningLimit" ];then
        tmpColor=$warningColor
    else
        tmpColor=$normalColor
    fi

    makeString "$tmpColor" "$ramSymbol" "$percent%"
}

getAkkuStatus(){
    alertAkkuCap=5
    warningAkkuCap=10
    akkuStatus=$(apm -l 2>/dev/null)

    if [ "$akkuStatus" -le "$alertAkkuCap" ];then
        tmpColor=$alertColor
    elif [ "$akkuStatus" -le "$warningAkkuCap" ];then
        tmpColor=$warningColor
    else
        tmpColor=$normalColor
    fi

    makeString "$tmpColor" "$akkuSymbol" "$akkuStatus%"
}

case $1 in
    "bat") getAkkuStatus;;
    "ram") getRamStatus;;
    "vol") getVolumeStatus;;
    "inet") getInetStatus;;
    "date") getDate;;
    "vpn") getVPN;;
    "jail") getJailStatus;;
esac

echo "$msgString"
