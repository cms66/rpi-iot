# The rpi-iot project
The aim of this project is to provide a set of scripts and supporting files to help with initial setup and security of a Raspberry Pi (using the latest Raspbian image, with a focus on the lite version). After initial setup there is a menu based system for extending capabilities including additional hardware (GPIO hats, camera etc.), image processing and for users with multiple RPi's, network file sharing and setup of a cluster of RPi's for parallel processing (targeted at home/school use for IoT and AI projects).

More detailed instructions and information about the project are available [here](../../wiki/The-rpi-iot-project).

## Quick instructions
These instructions assume:
 - OS version is bookworm
 - Following a naming convention of pinodeX (X = integer, unique for each RPi node in a cluster).
 - Windows computer used for preparation and connection to RPi.
 - Headless build (i.e no monitor/keyboard connected) so setup via ssh.
### Prepare SD card
 - Use Raspberry Pi Imager
### First boot
 - Connect required hardware + boot (wait for power only LED)
     - USB devices (e.g. robotic Arm) should be powered off during boot
 - Scan network for new RPi with a network scanner
     - From Windows Command prompt run the following command before and after RPi is powered up, then compare results in arp.txt file (saved to Desktop) to get IP and MAC address (= Physical Address).
        <pre><code>arp -a >> %USERPROFILE%\Desktop\arp.txt</code></pre>
    If you want a GUI:
     - Angry IP Scanner (https://sourceforge.net/projects/ipscan/files/latest/download), or if setting up a static IP then
     - Advanced IP scanner (https://www.advanced-ip-scanner.com/download/Advanced_IP_Scanner_2.5.3850.exe) and make a note of MAC address (doesn't always pick up raspberrypi.local hostname but shows as Manufacturer = Raspberry Pi Foundation).
 - Login via ssh as the user created during imaging and download this Repo
<pre><code>git clone https://github.com/cms66/rpi-iot.git
sudo sh rpi_setuo_base.sh</code></pre>
  - Select option to apply changes
      - Poweroff (recommended for multiple RPi scenario) to setup a static/reserved IP address on router (using MAC address noted earlier) or
      - Reboot (simple setup for a single RPi)

### Main setup
 - Login via ssh (created user/password) and run setup menu script as root
<pre><code>sudo sh local/src/shell/rpi_setup_menu.sh</code></pre>
 - Run System setup to remove default pi user, update system + install system/development tools
 - Run Hardware setup and use sub menu to setup connected devices (multiple devices can be configured, but reboot will be needed to apply changes)
 - Run NFS setup to configure server or client (required for OpenMPI)

### Testing
 - Hardware can be tested in various languages using the test menu
 <pre><code>sh local/src/shell/rpi_test_menu.sh</code></pre>
 - Not all device/language combinations will be available.
 - If using WiFi you can modify your networks/details by creating an updated wpa_supplicant.conf file and copying to SD card from Windows. On next boot of the RPi, the new configuration file will be moved to replace the existing configuration file and should connect to the new or modified network.
