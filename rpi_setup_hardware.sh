# Hardware setup
# TODO
# - Check for attached devices and configs for previous devices
# - 

show_hardware_menu()
{
	clear
	printf "Hardware setup menu \n----------"
	printf "select setup option or x to exit \n 1) CSI Camera \n 2) USB Camera \n 3) Sense Hat \n 4) Arduino \n 5) GPS \n 6) TFT LCD \n 7) Calibrate display \n 8) Bluetooth \n 9) Robotic arm \n"
}

# 1 CSI Camera - Works - requires reboot
setup_cam_csi()
{
	# Enable Camera
	echo "start_x=1" >> /boot/config.txt
	# grant access to camera for video group + add user to group
	echo 'SUBSYSTEM=="vchiq",GROUP="video",MODE="0660"' > /etc/udev/rules.d/10-vchiq-permissions.rules
	usermod -a -G video $usrname
	apt-get -y install python-picamera python3-picamera
	read -p "CSI camera setup done, press enter to return to menu" input	
}

# 2 USB Camera - Works - requires reboot
setup_cam_usb()
{
	# grant access to camera for video group + add user to group
	echo 'SUBSYSTEM=="vchiq",GROUP="video",MODE="0660"' > /etc/udev/rules.d/10-vchiq-permissions.rules
	usermod -a -G video $usrname
	apt-get install v4l-utils
	echo "bcm2835-v4l2" >> /etc/modules
	read -p "USB camera setup done, press enter to return to menu" input
}

# 3 Sense Hat - Works - requires reboot
setup_sense_hat()
{
	apt-get -y install sense-hat i2c-tools
	echo "dtparam=i2c_arm=on" >> /boot/config.txt
	usermod -a -G i2c,input $usrname
	read -p "Sense Hat setup done, press enter to return to menu" input
}

# 4 Arduino
setup_arduino()
{
	read -p "Arduino setup TODO, press enter to return to menu" input
}

# 5 GPS
setup_gps()
{
	sed -i 's/USBAUTO=\"true\"/USBAUTO=\"false\"/g' /etc/default/gpsd
	sed -i 's/GPSD_OPTIONS=\"\"/GPSD_OPTIONS=\"-n\"/g' /etc/default/gpsd
	sed -i 's/DEVICES=\"\"/DEVICES=\"\/dev\/ttyAMA0\"/g' /etc/default/gpsd
	sed -i 's/console=serial0,115200 //g' /boot/cmdline.txt
	echo "pps-gpio" >> /etc/modules
	echo "enable_uart=1" >> /boot/config.txt
	echo "dtoverlay=pi3-miniuart-bt" >> /boot/config.txt
	echo "dtoverlay=pps-gpio,gpiopin=4" >> /boot/config.txt
	systemctl enable gpsd
	read -p "GPS setup done, press enter to return to menu" input
}

# 6 TFT LCD display
setup_tft_lcd()
{
	git clone https://github.com/goodtft/LCD-show.git
	chmod -R 755 LCD-show
	cd LCD-show
	./LCD35-show
	read -p "TFT LCD setup done, press enter to return to menu" input
}

# 7 Calibrate display
calib_display()
{
	cd LCD-show
	dpkg -i -B xinput-calibrator_0.7.5-1_armhf.deb
	read -p "Display calibration done, press enter to return to menu" input
}

# 8 Bluetooth - onboard or dongle
setup_bluetooth()
{
	read -p "Bluetooth setup TODO, press enter to return to menu" input
}

# 9 Robotic arm
setup_robot_arm()
{
	echo 'SUBSYSTEM=="usb",ATTRS{idVendor}=="1267",ATTRS{idProduct}=="0000",MODE="0660",GROUP="$usrname",SYMLINK+="robotarm%n"' >> /etc/udev/rules.d/11-usb-permissions.rules
	pip install pyusb
	pip3 install pyusb
}
show_hardware_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) setup_cam_csi;;
	    2) setup_cam_usb;;
	    3) setup_sense_hat;;
	    4) setup_arduino;;
	    5) setup_gps;;
		6) setup_tft_lcd;;
		7) calib_display;;
		8) setup_bluetooth;;
		9) setup_robot_arm;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_hardware_menu
	read -p "Select option or x to exit to main menu: " n
done


