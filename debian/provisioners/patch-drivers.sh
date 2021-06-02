#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
# Date:    2014.12.19
# Purpose: fix the correct USB Blaster device driver rules
#
###end documentation############################################################
mkdir -p /etc/udev/rules.d
touch /etc/udev/rules.d/91-altera-usb-blaster.rules

echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"\n' >> /etc/udev/rules.d/91-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"\n' >> /etc/udev/rules.d/91-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"\n' >> /etc/udev/rules.d/91-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"\n' >> /etc/udev/rules.d/91-altera-usb-blaster.rules

udevadm control --reload
