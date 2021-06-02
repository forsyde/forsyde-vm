#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
# Date:    2014.12.19
# Purpose: This script downloads and installs the Altera University Program
# Comment: In the unlikely case that the link is broken, you have to acquire the
#          package manually from http://www.altera.com/education/univ/software/upds/unv-upds.html
#           * place the archive inside the Monkey's 'packages' folder. 
#           * invalidate the '#Dl' command, by adding some spaces after #
#           * validate the '#Dfml' command
#           * comment out the 'wget...' line of code
#          Otherwise, if it still does not work, contact me.

#     Dfml altera_upds_setup.tar 64d65e4843b88320d1ac1700a43bb8d2 ftp://ftp.altera.com/up/pub/Altera_Material/13.0/altera_upds_setup.tar
#Dl ftp://ftp.altera.com/up/pub/Altera_Material/13.0/altera_upds_setup.tar
#
###end documentation############################################################

wget --progress=bar:force ftp://ftp.altera.com/up/pub/Altera_Material/13.0/altera_upds_setup.tar -P /tmp/ 2>&1
mkdir /tmp/aupinstall
tar -xvf /tmp/altera_upds_setup.tar -C /tmp/aupinstall
rm /tmp/altera_upds_setup.tar

cd /tmp/aupinstall
sudo QUARTUS_ROOTDIR=/opt/altera/13.0sp1/quartus SOPC_KIT_NIOS2=/opt/altera/13.0sp1/nios2eds ./install_altera_upds
cd
rm -rf /tmp/aupinstall

