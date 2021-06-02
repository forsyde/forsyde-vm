#!/bin/bash
groupadd -f cdrom
groupadd -f floppy
groupadd -f sudo
groupadd -f audio
groupadd -f dip
groupadd -f video
groupadd -f plugdev
groupadd -f netdev
useradd -d /home/forsyde -m -G cdrom,floppy,sudo,audio,dip,video,plugdev,netdev forsyde
echo 'forsyde:forsyde' | chpasswd
