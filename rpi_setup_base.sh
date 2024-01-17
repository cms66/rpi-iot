# First boot - Base setup
# Assumes
# - rpi imager used to configure user/hostname
# - login as created user and download from github
# git clone https://github.com/cms66/rpi-iot.git
# Sudo run this script as created user from home directory
# TODO
# - Rebuild local.tgz with more generic structure

#read -p "Username for setup (you are running as root): " usrname
usrname=$(logname)
# create local folder structure for created user with code examples
tar -xvzf /home/$usrname/local.tgz -C /home/$usrname
rm local.tgz
# move build scripts  to local folder + set owner to created user
mv /home/$usrname/rpi_*.sh /home/$usrname/local/src/shell
mv /home/$usrname/nfs-export.tgz /home/$usrname/local/src/shell
chown -R $usrname:$usrname /home/$usrname/local/
# Add bash alias for setup menu
echo "alias mysetup=\"sudo sh /home/$usrname/local/src/shell/rpi_setup_menu.sh\"" >> /home/$usrname/.bashrc
echo "alias mytest=\"sudo sh /home/$usrname/local/src/shell/rpi_test_menu.sh\"" >> /home/$usrname/.bashrc

# Networking
piname=$(hostname)
echo "127.0.0.1   $piname.local $piname" >> /etc/hosts
localip=$(hostname -I | awk '{print $1}')
echo "$localip   $piname.local $piname" >> /etc/hosts
sed -i "s/rootwait/rootwait ipv6.disable=1/g" /boot/firmware/cmdline.txt

# Disable root SSH login
sed -i 's/#PermitRootLogin\ prohibit-password/PermitRootLogin\ no/g' /etc/ssh/sshd_config

# Set default shell to bash
echo "dash dash/sh boolean false" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Reboot or Poweroff (if static IP setup needed on router)
read -p "Finished base setup, press p to poweroff (if setting a static IP on router) or any other key to reboot, then login as $usrname: " input
if [ X$input = X"p" ]
then
	poweroff
else
	reboot
fi
