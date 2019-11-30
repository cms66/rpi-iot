# Login as created user and sudo run
# Remove default user pi
userdel -r -f pi
# Install software
# - Update
apt-get --force-yes -y update
apt-get --force-yes -y upgrade
#  - System tools + Development
apt-get --force-yes -y install python python2.7-dev python3-dev python-pip python3-pip gcc g++ gfortran libraspberrypi-dev libomp-dev git-core build-essential cmake pkg-config make screen htop stress zip nfs-common
read -p "Finished System setup, press enter to return to menu" input

