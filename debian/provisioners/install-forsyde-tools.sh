# install system C as a dependency
# current fiexd version is 2.3.3
# TODO: Make the systemc version external
wget -O /tmp/systemc-2.3.3.tar.gz -c https://www.accellera.org/images/downloads/standards/systemc/systemc-2.3.3.tar.gz
tar xf /tmp/systemc-2.3.3.tar.gz --directory=/tmp
mkdir -p /tmp/systemc-2.3.3/build
cd /tmp/systemc-2.3.3/build
/tmp/systemc-2.3.3/configure --with-unix-layout 
make install
cd /tmp

# install forsyde proper things
## system C
git clone https://github.com/forsyde/ForSyDe-SystemC.git /tmp/forsyde-systemc
cp -r /tmp/forsyde-systemc/src /usr/include
## shallow
stack install forsyde-shallow

# stack install forsyde-deep
