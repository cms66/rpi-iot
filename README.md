# The rpi-iot project
The aim of this project is to provide a set of scripts and supporting files to help with initial setup and security of a Raspberry Pi (using the latest Raspbian image, with a focus on the lite version). After initial setup there is a menu based system for extending capabilities including additional hardware (GPIO hats, camera etc.), image processing and for users with multiple RPi's, network file sharing and setup of a cluster of RPi's for parallel processing (targeted at home/school use for IoT and AI projects).

More detailed instructions and information about the project are available [here](../../wiki/The-rpi-iot-project).

## Quick instructions
These instructions assume:
 - Following a naming convention of pinodeX (X = integer, unique for each RPi node in a cluster).
 - Windows computer used for preparation and connection to RPi.
 - Headless build (i.e no monitor/keyboard connected) so setup via ssh.
### Prepare SD card
 - Download latest lite image from https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit
 - Unzip and write image to micro SD card (8 GB minimum, 16 GB recommended and Class 10) with win32diskimager (https://sourceforge.net/projects/win32diskimager/)
 - If a second drive is shown (Secure Digital storage device) or "format partition" message popup then
     - DO NOT click OK to format SD card
     - Remove drive letter. Download and run MiniTool Partition Wizard (https://www.partitionwizard.com/download/v11/pw11-free.exe). Select the second drive and right click then select hide partition (= remove drive letter)
 - Rename SD card volume to PINODE + node number.
 - Download https://github.com/cms66/rpi-iot/archive/master.zip and extract files.
 - If the RPi will be using WiFi then edit wpa_supplicant.conf with a plain text editor (Notepad or Notepad++ from https://notepad-plus-plus.org/downloads/).
 - Copy the files to SD card (only copy wpa_supplicant.conf if using WiFi rather than a wired connection). Just the files should be copied, not the rpi-iot folder.

### First boot
 - Connect required hardware + boot (wait for power only LED)
     - USB devices (e.g. robotic Arm) should be powered off during boot
 - Scan network for new RPi with a network scanner
     - From Windows Command prompt run the following command before and after RPi is powered up, then compare results in arp.txt file (saved to Desktop) to get IP and MAC address (= Physical Address).
        <pre><code>arp -a >> %USERPROFILE%\Desktop\arp.txt</code></pre>
    If you want a GUI:
     - Angry IP Scanner (https://sourceforge.net/projects/ipscan/files/latest/download), or if setting up a static IP then
     - Advanced IP scanner (https://www.advanced-ip-scanner.com/download/Advanced_IP_Scanner_2.5.3850.exe) and make a note of MAC address (doesn't always pick up raspberrypi.local hostname but shows as Manufacturer = Raspberry Pi Foundation).
 - Login via ssh (User = pi, Password = raspberry) and run base setup script as root
<pre><code>sudo sh /boot/firmware/rpi-iot-bookworm/rpi_setup_base.sh</code></pre>
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
