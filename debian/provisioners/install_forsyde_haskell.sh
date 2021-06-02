#!/bin/bash

###begin documentation##########################################################
#
# Author:  George Ungureanu <ugeorge@kth.se>
# Date:    2015.01.08
# Purpose: ForSyDe-Haskell EDSL
# Comment: 
#
###end documentation############################################################

sudo apt-get install -y git
sudo apt-get install -y haskell-platform
sudo apt-get install -y ghc-haddock


git clone https://gitr.sys.kth.se/ingo/forsyde-shallow.git /tmp
cd /tmp/forsyde-shallow

./Setup.hs configure
./Setup.hs build
./Setup.hs haddock


