# The rpi-iot project
The aim of this project is to provide a set of scripts and supporting files to help with initial setup and security of a Raspberry Pi (using the latest Raspbian image, with a focus on the lite version). After initial setup there is a menu based system for extending capabilities including additional hardware (GPIO hats, camera etc.), network file sharing, image processing and for users with multiple RPi's, it also supports setup of a cluster of RPi's for parallel processing (targeted at home/school use for IoT).

More detailed instructions and information about the project are available [here](../../wiki/The-rpi-iot-project).

## Quick instructions
These instructions assume following a naming convention of pinodeX.local (X = integer, unique for each RPi in a cluster).
1. Base install
	a. Download latest lite image from https://www.raspberrypi.org/downloads/raspbian/
	b. Unzip and burn image to micro SD card (recommended 16 GB, Class 10) with win32diskimager (https://sourceforge.net/projects/win32diskimager/)
		i. If second drive is shown (Secure Digital storage device) or format partition message popup then run MiniTool Partition Wizard (https://www.partitionwizard.com/download/v11/pw11-free.exe) and hide partition (= remove drive letter)
		ii. Rename SD card volume to PINODE + node number
		iii. Copy build files to SD card
			i. Edit wpa_supplicant.conf
2. First boot
	a. Connect required hardware + boot
	b. Wait for power only LED
	c. Scan network for raspberrypi.local with angry IP scanner (https://angryip.org/download/)
	d. Configure reserved IP on router if needed (100+ = Wired, 200+ = WiFi) and reboot
	e. Login via ssh
		i. User = pi
		ii. Password = raspberry
		iii. sudo sh /boot/rpi_setup_base.sh (reboots)
3. SSH login as created user and sudo run setup menu script
	a. sudo sh local/src/shell/rpi_setup_config.sh
Run System setup to remove default pi user, update system + install system tools


