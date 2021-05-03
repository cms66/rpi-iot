# Login as created user and sudo run
# Remove default user pi
userdel -r -f pi
# Install software
# Disable Microsoft Repo
echo "0.0.0.0 packages.microsoft.com" >> /etc/hosts
apt-mark hold raspberrypi-sys-mods
rm -vf /etc/apt/trusted.gpg.d/microsoft.gpg
touch /etc/apt/trusted.gpg.d/microsoft.gpg
chattr +i /etc/apt/trusted.gpg.d/microsoft.gpg
# - Update
apt-get -y update
apt-get -y upgrade
#  - System tools + Development
apt-get -y install python python2.7-dev python3-dev python-pip python3-pip gcc g++ gfortran libraspberrypi-dev libomp-dev git-core build-essential cmake pkg-config make screen htop stress zip nfs-common
#pip install --upgrade pip
#pip3 install --upgrade pip
# TODO - fail2ban ufw

# Configure firewall (ufw)
#ufw allow 22
#ufw logging on
#ufw enable

# Configure fail2ban
#cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
#cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

read -p "Finished System setup, press enter to return to menu" input

