# Login as created user and sudo run
# Remove default user pi
userdel -r -f pi
# Install software
# - Update
apt-get -y update
apt-get -y upgrade
#  - System tools + Development
apt-get -y install python python2.7-dev python3-dev python-pip python3-pip gcc g++ gfortran libraspberrypi-dev libomp-dev git-core build-essential cmake pkg-config make screen htop stress zip nfs-common
# TODO - add security
# apt-get -y install fail2ban ufw

# Configure firewall (ufw)
#ufw allow 22
#ufw logging on
#ufw enable

# Configure fail2ban
#cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
#cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

read -p "Finished System setup, press enter to return to menu" input

