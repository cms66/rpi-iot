# First boot - Base setup
# SSH login as pi/raspberry
# sudo run this script
# TODO
# - Rebuild local.tgz with more generic structure

# setup users and passwords
echo "Setting up security for root account and creating new user to replace the default pi user"
echo "set password for root"
passwd root
# Add user with home direcory, bash shell and sudo access
echo "Create user"
read -p "Full Name: " fname
read -p "User Name: " usrname
useradd -m -s /bin/bash -G sudo -c "$fname" $usrname
# set password for created user
passwd $usrname
# create local folder structure for created user
echo "Creating local folders for $usrname"
tar -xvzf /boot/local.tgz -C /home/$usrname/
# copy build scripts to local folder + set owner to created user
cp /boot/rpi_*.sh /home/$usrname/local/src/shell
chown -R $usrname.$usrname /home/$usrname/local/

# Networking
read -p "Networking - Hostname for RPi (e.g. pinode1): " piname
echo $piname > /etc/hostname
sed -i "s/raspberrypi/$piname.local $piname/g" /etc/hosts
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
