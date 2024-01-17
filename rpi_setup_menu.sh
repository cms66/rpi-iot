# Setup main menu
# Check/Run other setup scripts
# TODO
# - 

show_main_menu()
{
	clear
	printf "Setup Main menu \n--------------\n"
	printf "select setup option or x to exit \n 1) System (Run this once to update system and improve security after first boot) \n 2) Hardware \n 3) NFS \n 4) SSH - Shared keys \n 5) OpenMPI \n 6) OpenCV \n 7) OpenCL \n"
}

#read -p "Username for setup (you are running as root): " usrname
usrname=$(logname)
export usrname

show_main_menu
read -p "Select option or x to exit: " n

while [ $n != "x" ]; do
	case $n in
		1) sh /home/$usrname/local/src/shell/rpi-iot/rpi_setup_system.sh;;
		2) sh /home/$usrname/local/src/shell/rpi-iot/rpi_setup_hardware.sh;;
		3) sh /home/$usrname/local/src/shell/rpi-iot/rpi_setup_nfs.sh;;
		4) sh /home/$usrname/local/src/shell/rpi-iot/rpi_setup_ssh_keys.sh;;
		5) sh /home/$usrname/local/src/shell/rpi-iot/rpi_setup_openmpi.sh;;
		6) sh /home/$usrname/local/src/shell/rpi-iot/rpi_setup_opencv.sh;;
		7) sh /home/$usrname/local/src/shell/rpi-iot/rpi_setup_opencl.sh;;
		*) read -p "invalid option - press enter to return to menu" errkey;;
	esac
	show_main_menu
	read -p "Select option or x to exit: " n
done
