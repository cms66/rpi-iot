# The rpi-iot project
The aim of this project is to provide a set of scripts and supporting files to help with initial setup and security of a Raspberry Pi (using the latest Raspbian image, with a focus on the lite version). After initial setup there is a menu based system for extending capabilities including additional hardware (GPIO hats, camera etc.), image processing and for users with multiple RPi's, network file sharing and setup of a cluster of RPi's for parallel processing (targeted at home/school use for IoT).

More detailed instructions and information about the project are available [here](../../wiki/The-rpi-iot-project).

## Quick instructions
These instructions assume:
 - Following a naming convention of pinodeX.local (X = integer, unique for each RPi in a cluster).
 - Windows computer used for preparation and connection to RPi.
 - Headless build (i.e no monitor/keyboard connected) so setup via ssh.
### Prepare SD card
 - Download latest lite image from https://www.raspberrypi.org/downloads/raspbian/
 - Unzip and write image to micro SD card (8 GB minimum, 16 GB recommended and Class 10) with win32diskimager (https://sourceforge.net/projects/win32diskimager/)
 - If a second drive is shown (Secure Digital storage device) or "format partition" message popup then download and run MiniTool Partition Wizard (https://www.partitionwizard.com/download/v11/pw11-free.exe). Select the second drive and hide partition (= remove drive letter)
 - Rename SD card volume to PINODE + node number.
 - Download https://github.com/cms66/rpi-iot/archive/master.zip and extract files.
 - If the RPi will be using WiFi then edit wpa_supplicant.conf with a plain text editor (Notepad or Notepad++ from https://notepad-plus-plus.org/downloads/). 
 - Copy the files to SD card (only copy wpa_supplicant.conf if using WiFi rather than a wired connection).

### First boot
 - Connect required hardware + boot (wait for power only LED)
 - Scan network for new RPi with a network scanner
     - Angry IP Scanner (https://sourceforge.net/projects/ipscan/files/latest/download), or if setting up a static IP then
     - Advanced IP scanner (https://www.advanced-ip-scanner.com/download/Advanced_IP_Scanner_2.5.3850.exe) and make a note of MAC address (doesn't always pick up raspberrypi.local hostname but shows as Manufacturer = Raspberry Pi Foundation).
 - Login via ssh (User = pi, Password = raspberry) and run base setup script as root
<pre><code>sudo sh /boot/rpi_setup_base.sh</code></pre>
  - Select option to apply changes
      - Poweroff (recommended for multiple RPi scenario) to setup a static/reserved IP address on router (using MAC address noted earlier) or
      - Reboot (simple setup for a single RPi)

### Main setup
 - Login via ssh (created user/password) and run setup menu script as root
<pre><code>sudo sh local/src/shell/rpi_setup_menu.sh</code></pre>
 - Run System setup to remove default pi user, update system + install system/development tools
 - Run Hardware setup and use sub menu to setup connected devices
 - Run NFS setup to configure server or client (required for OpenMPI)

### Testing
 - Hardware can be tested in various languages using the test menu
 <pre><code>sh local/src/shell/rpi_test_menu.sh</code></pre>
 - Not all device/language combinations will be available.
