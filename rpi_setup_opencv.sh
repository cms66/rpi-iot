# OpenCV 4.5.2
# TODO
# - Optimisation
# - Set make cores according to RPi model
# - menu
# - client install

cd /home/$usrname
apt-get -y install libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libatlas-base-dev python3-numpy
wget https://files.pythonhosted.org/packages/3f/d3/ecb4d108f6c1041d24842a345ee0123cd7f366ba75cf122601e856d42ba2/imutils-0.5.4.tar.gz
tar -xvzf imutils-0.5.4.tar.gz
cd imutils-0.5.4
python3 setup.py install
ldconfig
cd /home/$usrname
rm -rf imutils*
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.2.zip
unzip opencv.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.2.zip
unzip opencv_contrib.zip
#pip install numpy imutils
#pip3 install numpy imutils
mkdir /home/$usrname/opencv-4.5.2/build
cd /home/$usrname/opencv-4.5.2/build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_PYTHON_EXAMPLES=OFF -D ENABLE_NEON=ON -D ENABLE_VFPV3=ON -D OPENCV_ENABLE_NONFREE=ON -D OPENCV_EXTRA_MODULES_PATH=/home/$usrname/opencv_contrib-4.5.2/modules -D BUILD_EXAMPLES=OFF ..
sed -i "s/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g" /etc/dphys-swapfile
/etc/init.d/dphys-swapfile restart
cores=$(nproc)
if [ $cores -gt 1 ]
then
	((cores=$cores-1))
else
	cores=1
fi
make -j$cores
make install
ldconfig
sed -i "s/CONF_SWAPSIZE=2048/CONF_SWAPSIZE=100/g" /etc/dphys-swapfile
/etc/init.d/dphys-swapfile restart
cd /home/$usrname
rm -rf opencv*
read -p "OpenCV 4.5.2 - install finished, press enter to return to menu" input
