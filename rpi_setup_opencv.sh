# OpenCV 4.5.5
# TODO
# - Optimisation
# - Set make cores according to RPi model
# - menu
# - client install

cd /home/$usrname
apt-get -y install python3-numpy libjpeg-dev libtiff-dev libgif-dev libgstreamer1.0-dev gstreamer1.0-gtk3 libgstreamer-plugins-base1.0-dev gstreamer1.0-gl libavcodec-dev libavformat-dev libswscale-dev libgtk2.0-dev libcanberra-gtk* libxvidcore-dev libx264-dev libgtk-3-dev libtbb2 libtbb-dev libdc1394-22-dev libv4l-dev libopenblas-dev libatlas-base-dev libblas-dev libjasper-dev liblapack-dev libhdf5-dev protobuf-compiler
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.5.zip
unzip opencv.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.5.zip
unzip opencv_contrib.zip
mkdir /home/$usrname/opencv-4.5.5/build
cd /home/$usrname/opencv-4.5.5/build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/home/$usrname/opencv_contrib-4.5.5/modules -D ENABLE_NEON=ON -D ENABLE_VFPV3=ON -D WITH_OPENMP=ON -D WITH_OPENCL=OFF -D BUILD_ZLIB=ON -D BUILD_TIFF=ON -D WITH_FFMPEG=ON -D WITH_TBB=ON -D BUILD_TBB=ON -D BUILD_TESTS=OFF -D WITH_EIGEN=OFF -D WITH_GSTREAMER=ON -D WITH_V4L=ON -D WITH_LIBV4L=ON -D WITH_VTK=OFF -D WITH_QT=OFF -D OPENCV_ENABLE_NONFREE=ON -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages -D OPENCV_GENERATE_PKGCONFIG=ON -D BUILD_EXAMPLES=OFF ..
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
read -p "OpenCV 4.5.5 - install finished, press enter to return to menu" input
