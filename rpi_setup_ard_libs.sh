# Install Arduino libraries to /usr/share/arduino/libraries/

wget -O protothreads.zip https://roboticsbackend.com/wp-content/uploads/2019/06/pt.zip
unzip protothreads.zip -d /usr/share/arduino/libraries/
rm protothreads.zip

wget -O NewPing.zip https://bitbucket.org/teckel12/arduino-new-ping/downloads/NewPing_v1.9.1.zip
unzip NewPing.zip -d /usr/share/arduino/libraries/
rm -f NewPing.zip

wget -O AccelStepper.zip https://github.com/waspinator/AccelStepper/archive/master.zip
unzip AccelStepper.zip -d /usr/share/arduino/libraries/
mv /usr/share/arduino/libraries/AccelStepper-master /usr/share/arduino/libraries/AccelStepper
rm -f AccelStepper.zip

wget -O TinyGPSPlus.zip https://github.com/mikalhart/TinyGPSPlus/archive/v1.0.2b.zip
unzip TinyGPSPlus.zip -d /usr/share/arduino/libraries/
mv /usr/share/arduino/libraries/TinyGPSPlus-1.0.2b /usr/share/arduino/libraries/TinyGPS++
rm -f TinyGPSPlus.zip
