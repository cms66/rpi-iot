# Login as created user and sudo run
# Install software
# - Update
apt-get -y update
apt-get -y upgrade
#  - System tools + Development
apt-get -y install python3-dev gcc g++ gfortran libraspberrypi-dev libomp-dev git-core build-essential cmake pkg-config make screen htop stress zip nfs-common

# - Create python Virtual Environment and bash alias for activation
python -m venv /home/$usrname/.venv
echo "alias myvp=\"source ~/.venv/bin/activate\"" >> /home/$usrname/.bashrc
chown -R $usrname:$usrname /home/$usrname/.venv

# TODO - fail2ban ufw

# Configure firewall (ufw)
#ufw allow 22
#ufw logging on
#ufw enable

# Configure fail2ban
#cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
#cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

read -p "Finished System setup, press enter to return to menu" input

