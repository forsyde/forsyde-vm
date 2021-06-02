# install lustre v4
cd /tmp
wget -c -O /tmp/lustre.tgz https://www-verimag.imag.fr/DIST-TOOLS/SYNCHRONE/lustre-v4/distrib/linux64/lustre-v4-III-e-linux64.tgz
mkdir -p /opt/lustre
tar xvfz /tmp/lustre.tgz --directory=/opt/lustre
LUSTRE_DIR=`find /opt/lustre -type d -name "lustre-v4*"`
echo "export LUSTRE_INSTALL=$LUSTRE_DIR" > /etc/profile.d/lustre-setup.sh
echo '. $LUSTRE_INSTALL/setenv.sh' >> /etc/profile.d/lustre-setup.sh

# install lustre v6 tools
wget http://www-verimag.imag.fr/DIST-TOOLS/SYNCHRONE/lustre-v6/pre-compiled/`arch`-`uname`-lv6-bin-dist.tgz
tar xvfz `arch`-`uname`-lv6-bin-dist.tgz -C /opt/lustre
echo "export LV6_PATH=/opt/lustre/lv6-bin-dist" >> /etc/profile.d/lustre-setup.sh
cat /opt/lustre/v6-tools.sh >> /etc/profile.d/lustre-setup.sh
