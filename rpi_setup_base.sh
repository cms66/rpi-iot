# First boot - Base setup
# Assumes
# - rpi imager used to configure user/hostname
# - login as created user and download/extract from github
# Run this script as created user from home directory
# TODO
# - Rebuild local.tgz with more generic structure

read -p "Username for setup (you are running as root): " usrname
# create local folder structure for created user with code examples
tar -xvzf /boot/firmware/local.tgz -C /home/$usrname
#rm local.tgz
# copy build scripts to local folder + set owner to created user
mv /boot/firmware/rpi_*.sh /home/$usrname/local/src/shell
mv /boot/firmware/nfs-export.tgz /home/$usrname/local/src/shell
chown -R $usrname:$usrname /home/$usrname/local/

# Networking
piname=$(hostname)
echo "127.0.0.1   $piname.local $piname" >> /etc/hosts
localip=$(hostname -I | awk '{print $1}')
echo "$localip   $piname.local $piname" >> /etc/hosts
sed -i "s/rootwait/rootwait ipv6.disable=1/g" /boot/cmdline.txt

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
