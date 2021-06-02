#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
# Date:    2014.12.19
# Purpose: ForSyDe-SystemC library and environment
# Comment: I don't know if the Accelera link works for everybody. In case the
#          configuration fails, get SystemC 2.3.0 from the Accelera Initiative download page:
#          http://www.accellera.org/downloads/standards/systemc
#          register, and download systemc-2.3.0.tgz

#Dfml systemc-2.3.0.tgz c26b9116f29f1384e21ab8abdb2dd70f www.accellera.org/downloads/standards/systemc/accept_license/accepted_download/systemc-2.3.0.tgz
#
###end documentation############################################################

sudo apt-get install -y build-essential
sudo apt-get install -y subversion
sudo apt-get install -y libboost-all-dev

mkdir /tmp/fsdsyscinstall
tar xvzf /tmp/systemc-2.3.0.tgz -C /tmp/fsdsyscinstall
cd /tmp/fsdsyscinstall/systemc-2.3.0
mkdir objdir
cd objdir
sudo mkdir /usr/local/systemc-2.3.0
sudo ../configure --prefix=/usr/local/systemc-2.3.0/
sudo make
sudo make install
rm -rf /tmp/fsdsyscinstall


sudo mkdir /usr/local/forsyde-systemc
cd /usr/local/forsyde-systemc
sudo svn co https://forsyde.ict.kth.se/svn/forsyde/ForSyDe-SystemC/trunk/ .

touch /usr/local/forsyde-systemc/Makefile.defs
echo "## Variable that points to SystemC installation path
SYSTEMC = /usr/local/systemc-2.3.0

## Variable that points to SFF (SystemC ForSyDe) installation path
SFF = /usr/local/forsyde-systemc/src

TARGET_ARCH = linux
CC     = g++  
OPT    = -O0 -std=c++11
DEBUG  = -g
SYSDIR = -I \$(SYSTEMC)/include
INCDIR = -I. -I.. \$(SYSDIR) -I\$(SFF)
LIBDIR = -L. -L.. -L\$(SYSTEMC)/lib-\$(TARGET_ARCH)

## Build with maximum gcc warning level
CFLAGS = -Wall -Wno-deprecated -Wno-return-type -Wno-char-subscripts -pthread \$(DEBUG) \$(OPT) \$(EXTRACFLAGS)
#CFLAGS = -arch i386 -Wall -Wno-deprecated -Wno-return-type -Wno-char-subscripts \$(DEBUG) \$(OPT) \$(EXTRACFLAGS)

LIBS   =  -lstdc++ -lm \$(EXTRA_LIBS) -lsystemc

EXE    = \$(MODULE).x

.PHONY: clean 

\$(EXE): \$(OBJS)
\t\$(CC) \$(CFLAGS) \$(INCDIR) \$(LIBDIR) -o \$@ \$(OBJS) \$(LIBS) 2>&1 | c++filt

## based on http://www.paulandlesley.org/gmake/autodep.html
%.o : %.cpp
\t\$(CC) \$(CFLAGS) \$(INCDIR) -c -MMD -o \$@ \$<
\t@cp \$*.d \$*.P; \\
\tsed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\\$\$//' \\
\t-e '/^\$\$/ d' -e 's/\$\$/ :/' < \$*.d >> \$*.P; \\
\trm -f \$*.d

clean:
\t-rm -f \$(OBJS) *~ \$(EXE) *.vcd *.wif *.isdb *.dmp *.P *.log

-include \$(SRCS:.cpp=.P)" > /usr/local/forsyde-systemc/Makefile.defs

mkdir /home/student/ForSyDe-workspace

cd /usr/local/forsyde-systemc
touch /home/student/.fsdk
echo 'PS1="\[\e[32;2m\]\w\[\e[0m\]\n[ForSyDe-SystemC]$ "

if [ "$FORSYDE_BASH_RUN" != "" ]
then
	return 0 # is already runníng
fi
FORSYDE_BASH_RUN=1

export LD_LIBRARY_PATH=/usr/local/systemc-2.3.0/lib-linux
export FORSYDE_MAKEDEFS=/usr/local/forsyde-systemc/Makefile.defs

echo "------------------------------------------------

ForSyDe Command Shell ['`gcc -v 2>&1 | tail -1`']
' > /home/student/.fsdk
svn info 2>&1 | tail -4 >> /home/student/.fsdk
echo '------------------------------------------------

Example designs can be found in
	/usr/local/forsyde-systemc/examples

"

cd ~/ForSyDe-workspace

function generate-makefile () {
touch Makefile
echo "
EXTRACFLAGS = 
EXTRA_LIBS =

MODULE = run
SRCS = \\$(wildcard *.cpp)

OBJS = \\$(SRCS:.cpp=.o)

include \\$(FORSYDE_MAKEDEFS)

CFLAGS += -DFORSYDE_INTROSPECTION

" > Makefile
}

' >> /home/student/.fsdk

chmod 777 ~/.fsdk


touch ~/Desktop/ForSyDe_SystemC_Shell.desktop
echo '[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=gnome-ccperiph
Name[en_US]=ForSyDe Shell
Exec=lxterminal  --command "bash --rcfile /home/student/.fsdk"
Comment[en_US]=Launches a pre-configured shell environment for ForSyDe
Name=ForSyDe Shell
Comment=Launches a pre-configured shell environment for ForSyDe
Icon=ibus-engine
StartupNotify=true' > ~/Desktop/ForSyDe_SystemC_Shell.desktop
