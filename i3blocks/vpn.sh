if ifconfig wg1 > /dev/null 2>&1;then
	echo " VPN  "
else
	if ifconfig wg0 > /dev/null 2>&1;then
		echo " VPN  "
	fi
fi
