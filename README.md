# The rpi-iot project
The aim of this project is to provide a set of scripts and supporting files to help with initial setup and security of a Raspberry Pi (using the latest Raspbian image, with a focus on the lite version). After initial setup there is a menu based system for extending capabilities including additional hardware (GPIO hats, camera etc.), network file sharing, image processing and for users with multiple RPi's, it also supports setup of a cluster of RPi's for parallel processing (targeted at home/school use for IoT).

More detailed instructions and information about the project are available [here](../../wiki/The-rpi-iot-project).

## Quick instructions
 
*1. Basic install
**a. Download latest lite image from https://www.raspberrypi.org/downloads/raspbian/
**b. Unzip and burn image to micro SD card (16 GB, Class 10) with win32diskimager (https://sourceforge.net/projects/win32diskimager/)
***i. If second drive is shown (Secure Digital storage device) or format partition message popup then run MiniTool Partition Wizard (https://www.partitionwizard.com/download/v11/pw11-free.exe) and hide partition (= remove drive letter)
***ii. Rename SD card volume to PINODE + node number
***iii. Copy build files to SD card
***i. Edit wpa_supplicant.conf


