#!/bin/bash

###begin documentation##########################################################
#
# Authors: George Ungureanu <ugeorge@kth.se>
#					 Rodolfo Jordao <jordao@kth.se>
# Date:    2021-06-02
# Purpose: Quartus 13.0sp1 Web (Free) edition.
# Comment: The Altera download links are quite resilient, so no worries there.
#          On the other hand, if that fails, go to http://dl.altera.com/?edition=web
#          select version 13.0sp1 and download the combined package. You need
#          to have a valid account on the Altera site, so you might have to 
#          subscribe to them...

# the permalink: https://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/QuartusSetupWeb-13.0.1.232.run
#
###end documentation############################################################

# make a temporary directory
mkdir -p /tmp/qinstall
# either download the file or use the one copied directly
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z ${QUARTUS_13_DOWNLOAD_URL+x} ]; then
    # this TAR_FILE is fed from the packer externally
    # make some space since the files are big
    tar xf $QUARTUS_13_TAR_FILE -C /tmp/qinstall
    rm $QUARTUS_13_TAR_FILE
else
	echo "Downloading quartus..."
	wget --quiet -O /tmp/qinstall/quartus.tar $QUARTUS_13_DOWNLOAD_URL 
	echo "Extracting quartus..."
    tar xf /tmp/qinstall/quartus.tar --directory=/tmp/qinstall
    rm /tmp/qinstall/quartus.tar
fi
# echo "Installing Quartus tools in /opt/altera/13.0sp1..."
# echo "Sit back, relax, grab a milkshake, watch a movie... seriously, it will take ages!"
echo "Installing quartus..."
find /tmp/qinstall -type f -name "QuartusSetupWeb*.run" -exec {} --mode unattended --unattendedmodeui none --installdir /opt/altera/13.0sp1 \;
echo "Finished installing quartus."
# echo "Uninstalling the nasty subscription edition of Modelsim..."
chmod +x /opt/altera/13.0sp1/uninstall/modelsim_ae-13.0.1.232-uninstall.run
#cd /opt/altera/13.0sp1
#./uninstall/modelsim_ae-13.0.1.232-uninstall.run --mode unattended
# make some space since the files are big
rm -rf /tmp/qinstall

mkdir -p /etc/profile.d
echo 'export PATH="$PATH:/opt/altera/13.0sp1/quartus/bin"' > /etc/profile.d/altera13.sh
echo 'alias nios2shell="bash /opt/altera/13.0sp1/nios2eds/nios2_command_shell.sh"' >> /etc/profile.d/altera13.sh

# mkdir -p ~/Desktop
# touch ~/Desktop/Nios2_Shell.desktop
# echo '[Desktop Entry]
# Version=1.0
# Type=Application
# Terminal=false
# Icon[en_US]=gnome-ccperiph
# Name[en_US]=NIOS 2 Shell
# Exec=lxterminal  --command "/home/student/n2sdk"
# Comment[en_US]=Launches a pre-configured shell environment for NIOS 2
# Name=NIOS 2 Shell
# Comment=Launches a pre-configured shell environment for NIOS 2
# Icon=ibus-engine
# StartupNotify=true' > ~/Desktop/Nios2_Shell.desktop

# touch ~/n2sdk
# echo '#!/bin/bash
# # Run this for a Nios II SDK bash shell
# export LM_LICENSE_FILE=@lic1.ict.kth.se
# SOPC_KIT_NIOS2=/opt/altera/13.0sp1/nios2eds
# export SOPC_KIT_NIOS2
# SOPC_BUILDER_PATH_130=/opt/altera/13.0sp1/nios2eds
# export SOPC_BUILDER_PATH_130
# unset GCC_EXEC_PREFIX
# QUARTUS_ROOTDIR=/opt/altera/13.0sp1/quartus
# export QUARTUS_ROOTDIR
# export PERL5LIB=/usr/lib/perl/5.18.2
# cd /home/student/Desktop/
# bash --rcfile $SOPC_BUILDER_PATH_130/nios2_command_shell.sh' > ~/n2sdk

