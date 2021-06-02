#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
# Date:    2014.12.19
# Purpose: The first commands that should be run during the first login.
# Comment: 
#
###end documentation############################################################

set -e
 
# Updating and Upgrading dependencies
sudo apt-get update -y -qq > /dev/null
sudo apt-get upgrade -y -qq > /dev/null
gconftool -s --type bool /apps/update-notifier/auto_launch false

if [ -e /dev/sdb ]
then
    echo "Secondary Hard drive is connected. Formatting and mounting"
	sudo mkdir /mnt/tmp
	(echo o; echo n; echo p; echo 1; echo ; echo; echo w) | sudo fdisk /dev/sdb
	sudo mkfs.ext3 /dev/sdb1
	sudo mount /dev/sdb1 /mnt/tmp
	mv /tmp/* /mnt/tmp
	sudo umount /dev/sdb1
	sudo mount /dev/sdb1 /tmp
	sudo chown student:student /tmp
else
    echo "Secondary Hard drive is not connected"
fi

mkdir ~/Desktop

