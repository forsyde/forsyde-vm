# update things quickly
# install all system requirements 
apt-get install -y autoconf
apt-get install -y automake
apt-get install -y build-essential
apt-get install -y g++-multilib
apt-get install -y gcc-multilib
apt-get install -y ghc-haddock
apt-get install -y git
apt-get install -y gnupg
apt-get install -y haskell-platform
apt-get install -y libboost-all-dev
apt-get install -y libc6-dev
apt-get install -y libffi-dev
apt-get install -y libgmp-dev
apt-get install -y libncurses5
apt-get install -y libsgutils2-dev
apt-get install -y libtool
apt-get install -y libusb-1.0-0-dev
apt-get install -y linux-headers-$(uname -r)
apt-get install -y netbase
apt-get install -y subversion
apt-get install -y wget
apt-get install -y xz-utils
apt-get install -y zlib1g-dev
#apt-get install -y libpng:i386
apt-get install -y expat:i386
apt-get install -y fontconfig:i386
apt-get install -y libc6:i386
apt-get install -y libcanberra0:i386
apt-get install -y libexpat1:i386
apt-get install -y libfreetype6:i386
apt-get install -y libgtk-3-0:i386
apt-get install -y libice6:i386
apt-get install -y libncurses5:i386
apt-get install -y libsm6:i386
apt-get install -y libx11-6:i386
apt-get install -y libxau6:i386
apt-get install -y libxdmcp6:i386
apt-get install -y libxext6:i386
apt-get install -y libxft2:i386
apt-get install -y libxrender1:i386
apt-get install -y libxt6:i386
apt-get install -y libxtst6:i386
apt-get install -y zlib1g:i386

# install vbox guest additions
mkdir /tmp/vboxguest
mount -o loop /tmp/VBoxGuestAdditions.iso /tmp/vboxguest
/tmp/vboxguest/VBoxLinuxAdditions.run

# haskell stack
# TODO: make the stack version fixed and external
wget -c https://get.haskellstack.org/stable/linux-x86_64.tar.gz \
    -O /tmp/stack.tar.gz
tar -xf /tmp/stack.tar.gz -C /tmp
find /tmp -type f -name "stack" -exec mv {} /usr/bin/stack \;
