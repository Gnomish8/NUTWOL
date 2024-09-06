#!/bin/bash

IP_ADDRESS="1.1.1.1"
WOL_MAC="AA:BB:CC:DD:EE:FF"
WOL_MAC2="AA:BB:CC:DD:EE:FF"
SubnetBroadcast="1.1.1.255"
Status="$(upsc YOURUPSNAME@localhost ups.status 2>&1 | grep -v '^Init SSL')"
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
