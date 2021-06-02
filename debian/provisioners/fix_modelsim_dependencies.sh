#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
# Date:    2014.12.19
# Purpose: Modelsim depends on a font which is no longer available in Ubuntu 14.
#          This script takes care of building it and providing it as a library.
# Comment: I do not know how long that link will work. It tries to download the 
#          package prior to the build process. In case it fails please contact me
#          to send it to you directly.
#
#Dfml freetype-2.4.12.tar.bz2 3463102764315eb86c0d3c2e1f3ffb7d http://nongnu.uib.no//freetype/freetype-2.4.12.tar.bz2 
#
###end documentation############################################################
sudo apt-get build-dep -y -a i386 libfreetype6
mkdir /tmp/ftinstall
tar -xjvf /tmp/freetype-2.4.12.tar.bz2 -C /tmp/ftinstall
rm /tmp/freetype-2.4.12.tar.bz2

cd /tmp/ftinstall/freetype-2.4.12
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
sudo make -j8

cd ~
sudo mkdir -p /opt/altera/13.0sp1/modelsim_ase/lib32
sudo cp /tmp/ftinstall/freetype-2.4.12/objs/.libs/libfreetype.so* /opt/altera/13.0sp1/modelsim_ase/lib32
sudo sed -i 's:dir=`dirname $arg0`:dir=/opt/altera/13.0sp1/modelsim_ase\
export LD_LIBRARY_PATH=${dir}/lib32:' /opt/altera/13.0sp1/modelsim_ase/bin/vsim
