#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
#          Rodolfo Jordao <jordao@kth.se>
# Date:    2021.08.30
# Purpose: fix the correct USB Blaster device driver rules
#
###end documentation############################################################
mkdir -p /etc/udev/rules.d
touch /etc/udev/rules.d/91-altera-usb-blaster.rules

# Intel FPGA Download Cable
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"' >> /etc/udev/rules.d/91-altera-usb-blaster.rules
echo 'SSUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"'>> /etc/udev/rules.d/91-altera-usb-blaster.rules
echo 'SSUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"'>> /etc/udev/rules.d/91-altera-usb-blaster.rules

# Intel FPGA Download Cable II
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"' >> /etc/udev/rules.d/91-altera-usb-blaster.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"' >> /etc/udev/rules.d/91-altera-usb-blaster.rules

udevadm control --reload
