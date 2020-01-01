# OpenCV 4.2.0
# TODO
# - Symlink for python import
# - Optimisation
cd /home/$usrname
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.2.0.zip
unzip opencv.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.2.0.zip
unzip opencv_contrib.zip
pip install numpy imutils
pip3 install numpy imutils
mkdir /home/$usrname/opencv-4.2.0/build
cd /home/$usrname/opencv-4.2.0/build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_PYTHON_EXAMPLES=OFF -D OPENCV_EXTRA_MODULES_PATH=/home/$usrname/opencv_contrib-4.2.0/modules -D BUILD_EXAMPLES=OFF ..
sed -i "s/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g" /etc/dphys-swapfile
/etc/init.d/dphys-swapfile stop
/etc/init.d/dphys-swapfile start
make -j4
make install
ldconfig
sed -i "s/CONF_SWAPSIZE=2048/CONF_SWAPSIZE=100/g" /etc/dphys-swapfile
/etc/init.d/dphys-swapfile stop
/etc/init.d/dphys-swapfile start
cd /home/$usrname
rm -f opencv*.zip
rm -rf opencv-4.2.0
read -p "OpenCV 4.2.0 - install finished, press enter to return to menu" input
