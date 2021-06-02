#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
# Date:    2014.12.19
# Purpose: Quartus 13.0sp1 Subscription edition.
# Comment: The Altera download links are quite resilient, so no worries there.
#          On the other hand, if that fails, go to 
#          https://www.altera.com/download/software/quartus-ii-se
#          select version 13.0sp1 and download the combined package. You need
#          to have a valid account on the Altera site, so you might have to 
#          subscribe to them...
#
#Dfml Quartus-13.0.1.232-linux.tar a809dd618670bab8b0bfb7f1a6f3d4dd http://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_tar/Quartus-13.0.1.232-linux.tar
#Dfml Quartus-13.0.1.232-devices-1.tar fac11159c3d8a202d3f84a17ec4f95d3 http://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_tar/Quartus-13.0.1.232-devices-1.tar
#
###end documentation############################################################

sudo apt-get install -y gcc-multilib g++-multilib expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 libcanberra0:i386 libpng12-0:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 libxt6:i386 libxtst6:i386


echo "Copying Quartus installer..."
mkdir /tmp/qinstall
tar -xvf /tmp/Quartus-13.0.1.232-linux.tar -C  /tmp/qinstall
rm /tmp/Quartus-13.0.1.232-linux.tar


echo "Installing Quartus tools in /opt/altera/13.0sp1..."
cd /tmp
printf %500s'y\n/opt/altera/13.0sp1\ny\nn\ny\nn\nn\nn\ny\n\nn\nn\n' | tr " " "\n" | sudo ./qinstall/components/QuartusSetup-13.0.1.232.run --mode text  
rm -rf /tmp/qinstall


echo "Installing Quartus devices..."
mkdir /tmp/devinstall
tar -xvf /tmp/Quartus-13.0.1.232-devices-1.tar -C  /tmp/devinstall
rm /tmp/Quartus-13.0.1.232-devices-1.tar
echo "/opt/altera/13.0sp1
y
y
y
y
n
n
n
y
" | sudo ./devinstall/components/DeviceInstall-13.0.1.232.run --mode text
cd ~
rm -rf /tmp/devinstall

mkdir -p ~/Desktop
touch ~/Desktop/Nios2_Shell.desktop
echo '[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=gnome-ccperiph
Name[en_US]=NIOS 2 Shell
Exec=lxterminal  --command "/home/student/.n2sdk"
Comment[en_US]=Launches a pre-configured shell environment for NIOS 2
Name=NIOS 2 Shell
Comment=Launches a pre-configured shell environment for NIOS 2
Icon=ibus-engine
StartupNotify=true' > ~/Desktop/Nios2_Shell.desktop

touch ~/.n2sdk
echo '#!/bin/bash
# Run this for a Nios II SDK bash shell
export LM_LICENSE_FILE=@lic1.ict.kth.se
SOPC_KIT_NIOS2=/opt/altera/13.0sp1/nios2eds
export SOPC_KIT_NIOS2
SOPC_BUILDER_PATH_130=/opt/altera/13.0sp1/nios2eds
export SOPC_BUILDER_PATH_130
unset GCC_EXEC_PREFIX
QUARTUS_ROOTDIR=/opt/altera/13.0sp1/quartus
MODELSIM_ROOTDIR=/opt/altera/13.0sp1/modelsim_ase
PATH=$MODELSIM_ROOTDIR/bin:$PATH
export QUARTUS_ROOTDIR
export PERL5LIB=/usr/lib/perl/5.18.2
cd /home/student/Desktop/
bash --rcfile $QUARTUS_ROOTDIR/sopc_builder/bin/nios_bash' > ~/.n2sdk

sudo touch /opt/altera/13.0sp1/nios2eds/kit_bash
echo '#!/bin/bash
#######################################
#
# kit_bash for Nios II Development Kit
# Version 10.0, Built Mon Jun 28 00:03:27 PDT 2010
#
# Define interactive-shell items for the
# Nios II software development.  Depends
# on kit_sh having been sourced earlier,
# to define $SOPC_KIT_NIOS2 and setup
# PATH, PERL5LIB.
#

alias nios2-fs2cli="$SOPC_KIT_NIOS2/bin/fs2/bin/clinios.exe $SOPC_KIT_NIOS2/bin/fs2/bin/initnios2.tcl"

echo
echo "------------------------------------------------"
echo "Welcome to the Nios II Embedded Design Suite"
echo "Version 10.0, Built Mon Jun 28 00:03:27 PDT 2010"
echo
echo "Example designs can be found in"
echo "    `pwd`/examples"
echo
echo "------------------------------------------------"

# |
# | source the user bashrc extender, if
# | they have one
# |

    user_bashrc="$SOPC_KIT_NIOS2/user.bashrc"

    if [ -f "$user_bashrc" ]
    then
        echo "(Executing user startup script: $user_bashrc)"
        source "$user_bashrc"
    else
        echo "(You may add a startup script: $user_bashrc)"
    fi


# (Note: nios_bash, which invokes this script, will
# append your previously existing PATH entries to the
# new current PATH, unless the old one contained a
# conflicting cygwin1.dll. So: you keep your old path
# always on Linux &c, and often on Windows too.)

# the end
' > /opt/altera/13.0sp1/nios2eds/kit_bash
sudo touch /opt/altera/13.0sp1/nios2eds/kit_sh
echo '#!/bin/sh
#######################################
#
# kit_sh for Nios II Development Kit
# Version 10.0, Built Mon Jun 28 00:03:27 PDT 2010
#
# This file is sourced by the SOPC Builder
# shell-environment setup script 
# ($QUARTUS_ROOTDIR/sopc_builder/bin/nios_sh)
#
#

SOPC_KIT_NIOS2=`pwd`

PATH=$SOPC_KIT_NIOS2/bin:$SOPC_KIT_NIOS2/bin/gnu/H-i686-pc-linux-gnu/bin:$SOPC_KIT_NIOS2/sdk2/bin:$PATH

PERL5LIB=$tmp_nios_root/bin:$PERL5LIB

SOPC_KIT_NIOS2=`safe_path_m "$SOPC_KIT_NIOS2"`
export SOPC_KIT_NIOS2


# ensure Quartus commands set-up environment properly
unset QUARTUS_QENV
' > /opt/altera/13.0sp1/nios2eds/kit_sh


chmod 777 ~/.n2sdk
sudo chmod 777 ~/.n2sdk /opt/altera/13.0sp1/nios2eds/kit_sh
sudo chmod 777 ~/.n2sdk /opt/altera/13.0sp1/nios2eds/kit_bash
