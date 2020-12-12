# Hardware setup
# TODO
# - Check for attached devices and configs for previous devices
# - Enable port on firewall for multiple camera streams

show_hardware_menu()
{
	clear
	printf "Hardware setup menu \n----------"
	printf "select setup option or x to exit \n 1) CSI Camera \n 2) USB Camera \n 3) Sense Hat \n 4) Calibrate Sense Hat \n 5) Arduino - USB \n 6) Arduino I2C \n 7) GPS \n 8) TFT LCD \n 9) Calibrate display \n 10) Bluetooth \n 11) Robotic arm \n 12) DVB TV Hat \n"
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
	# Set firewall rule - assumes pinodeX numbering with port 8080 + node number e.g pinode1 = port 8081
	hname=$(hostname)
	fport=$(((${hname//[^0-9]/}) + 8080))
	ufw allow $fport
	
	read -p "CSI camera setup done, press enter to return to menu" input	
}

# 2 USB Camera - Works - requires reboot
setup_cam_usb()
{
	# grant access to camera for video group + add user to group
	echo 'SUBSYSTEM=="vchiq",GROUP="video",MODE="0660"' > /etc/udev/rules.d/10-vchiq-permissions.rules
	usermod -a -G video $usrname
	apt-get -y install v4l-utils
	pip install v4l2
	pip3 install v4l2
	echo "bcm2835-v4l2" >> /etc/modules
	# Set firewall rule - assumes pinodeX numbering with port 8080 + node number e.g pinode1 = port 8081
	hname=$(hostname)
	fport=$(((${hname//[^0-9]/}) + 8080))
	ufw allow $fport
	read -p "USB camera setup done, press enter to return to menu" input
}

# 3 Sense Hat - Works - requires reboot
setup_sense_hat()
{
	apt-get -y install sense-hat i2c-tools
	echo "dtparam=i2c_arm=on" >> /boot/config.txt
	usermod -a -G i2c,input,video $usrname
	# Install cli calibration
	wget -O RTIMULib.zip https://github.com/RPi-Distro/RTIMULib/archive/master.zip
	unzip RTIMULib.zip
	cd RTIMULib-master/Linux/RTIMULibCal
	make
	make install
	cd /home/$usrname
	rm -rf RTIMULib*
	read -p "Sense Hat setup done, press enter to return to menu" input
}

# 4 Calibrate Sense Hat
calib_sense_hat()
{
	RTIMULibCal
	rm /home/$usrname/.config/sense_hat/RTIMULib.ini
	rm /root/RTEllipsoidFit//RTIMULib.ini
	mv -f RTIMULib.ini /etc
	read -p "Sense Hat calibration done, press enter to return to menu" input
}

# 5 Arduino - USB - Works
setup_arduino_usb()
{
	usermod -a -G dialout $usrname
	pip install pyserial
	pip3 install pyserial
	apt-get -y install arduino-core arduino-mk
	read -p "Arduino USB setup done, press enter to return to menu" input
}

# 6 Arduino - I2C
setup_arduino_i2c()
{
	read -p "Arduino I2C setup TODO, press enter to return to menu" input
}

# 7 GPS
setup_gps()
{
	apt-get -y install gpsd gpsd-clients python-gps
	sed -i 's/USBAUTO=\"true\"/USBAUTO=\"false\"/g' /etc/default/gpsd
	sed -i 's/GPSD_OPTIONS=\"\"/GPSD_OPTIONS=\"-n -G\"/g' /etc/default/gpsd
	sed -i 's/DEVICES=\"\"/DEVICES=\"\/dev\/serial0\"/g' /etc/default/gpsd
	sed -i 's/console=serial0,115200 //g' /boot/cmdline.txt
	echo "pps-gpio" >> /etc/modules
	echo "enable_uart=1" >> /boot/config.txt
	echo "dtoverlay=pi3-miniuart-bt" >> /boot/config.txt
	echo "dtoverlay=pps-gpio,gpiopin=4" >> /boot/config.txt
	systemctl enable gpsd
	read -p "GPS setup done, press enter to return to menu" input
}

# 8 TFT LCD display
setup_tft_lcd()
{
	git clone https://github.com/goodtft/LCD-show.git
	chmod -R 755 LCD-show
	cd LCD-show
	./LCD35-show
	read -p "TFT LCD setup done, press enter to return to menu" input
}

# 9 Calibrate display
calib_display()
{
	cd LCD-show
	dpkg -i -B xinput-calibrator_0.7.5-1_armhf.deb
	read -p "Display calibration done, press enter to return to menu" input
}

# 10 Bluetooth - onboard or dongle
setup_bluetooth()
{
	read -p "Bluetooth setup TODO, press enter to return to menu" input
}

# 11 Robotic arm
setup_robot_arm()
{
	echo 'SUBSYSTEM=="usb",ATTRS{idVendor}=="1267",ATTRS{idProduct}=="0000",MODE="0660",GROUP="$usrname",SYMLINK+="robotarm%n"' >> /etc/udev/rules.d/11-usb-permissions.rules
	pip install pyusb
	pip3 install pyusb
}

# 12 DVB TV Hat
setup_dvb_tv()
{
	apt-get -y install tvheadend
	ufw enable 9981
	read -p "DVB TV Hat setup done, press enter to return to menu" input
}

show_hardware_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
		1) setup_cam_csi;;
		2) setup_cam_usb;;
		3) setup_sense_hat;;
		4) calib_sense_hat;;
		5) setup_arduino_usb;;
		6) setup_arduino_i2c;;
		7) setup_gps;;
		8) setup_tft_lcd;;
		9) calib_display;;
		10) setup_bluetooth;;
		11) setup_robot_arm;;
		12) setup_dvb_tv;;
		*) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_hardware_menu
	read -p "Select option or x to exit to main menu: " n
done


