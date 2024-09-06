#!/bin/bash

IP_ADDRESS="192.168.2.110"
WOL_MAC="19:54:bc:45:dd:d8"
WOL_MAC2="9d:62:44:ce:c9:39"
SubnetBroadcast="192.168.2.255"
Status="$(upsc apc-1500@localhost ups.status 2>&1 | grep -v '^Init SSL')"
Online="OL"
OnBattery="OB DISCHRG"
OnLineCharging="OL CHRG"

if [[ $Status != $OnBattery ]]
then
	if ! ping -c 1 $IP_ADDRESS > /dev/null;
	then
	wakeonlan -i $SubnetBroadcast $WOL_MAC
	wakeonlan -i $SubnetBroadcast $WOL_MAC2
	echo "Magic Packet Sent"
	curl -d "Magic packets sent." https://ntfy.domain.com/channel
	else
		echo "Server online, no action needed"
	fi


else
	echo "On UPS power, exiting"
	curl -d "Servers are on UPS power, leaving offline." https://ntfy.domain.com/channel
fi
