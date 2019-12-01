# OpenCL (VCFCL)
cd /home/$usrname
mkdir ocl_build
cd ocl_build
# abhiTronix version
apt-get -y install llvm clang clang-format libclang-dev libbsd0 libc6 libedit2 libffi6 libgcc1 libncurses5 libstdc++6 libtinfo5 zlib1g llvm-dev ocl-icd-opencl-dev ocl-icd-dev opencl-headers clinfo
git clone https://github.com/abhiTronix/VC4CL.git
git clone https://github.com/abhiTronix/VC4C.git
git clone https://github.com/abhiTronix/VC4CLStdLib.git

cd VC4CLStdLib
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_DEBUG=OFF -DCROSS_COMPILE=OFF -DBUILD_DEB_PACKAGE=OFF .
sudo make
sudo make install

cd ../VC4C
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_DEBUG=OFF -DBUILD_DEB_PACKAGE=OFF .
sudo make
sudo make install
sudo ldconfig

cd ../VC4CL
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_DEBUG=OFF -DBUILD_DEB_PACKAGE=OFF -DBUILD_ICD=ON -DIMAGE_SUPPORT=ON .
sudo make
sudo make install

cd /home/$usrname
rm -rf ocl_build

read -p "OpenCL - install finished, press enter to return to menu" input