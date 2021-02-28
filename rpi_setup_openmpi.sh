# OpenMPI 4.1.0
show_mpi_menu()
{
	clear
	printf "MPI setup menu \n----------\n"
	printf "select setup option or x to exit \n 1) Build/install - local \n 2) Build/install - server \n 3) Install - client \n"
}

# 1 - Build/install local
install_local()
{
	cd /home/$usrname
	wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.0.tar.gz
	tar -xzf openmpi-4.1.0.tar.gz
	cd openmpi-4.1.0
	./configure
	cores=$(nproc)
	if [ $cores -gt 1 ]
	then
		((cores=$cores-1))
	else
		cores=1
	fi
	echo "cores for make: $cores"
	make -j$cores all
	make install	
	ldconfig	
	cd /home/$usrname
	rm -rf openmpi*
	mpirun --version
	read -p "OpenMPI 4.1.0 - Local install finished, press enter to return to menu" input
}

# 2- Build/install on server
install_server()
{
	cd /home/$usrname
	mkdir /opt/openmpi
	wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.0.tar.gz
	tar -xzf openmpi-4.1.0.tar.gz
	cd openmpi-4.1.0
	./configure --prefix=/opt/openmpi
	cores=$(nproc)
	if [ $cores -gt 1 ]
	then
		((cores=$cores-1))
	else
		cores=1
	fi
	echo "cores for make: $cores"
	make -j$cores all
	make install
	echo "/opt/openmpi/lib" >> /etc/ld.so.conf.d/openmpi.conf
	ldconfig
	echo "export PATH=$PATH:/opt/openmpi/bin" >> /etc/profile
	echo "/opt/openmpi 192.168.0.0/255.255.255.0(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
	exportfs -ra
	cd /home/$usrname
	rm -rf openmpi*
	mpirun --version
	read -p "OpenMPI 4.1.0 - Server install finished, press enter to return to menu" input
}

# 3- Install to run from server
install_client()
{
	read -p "Remote node (integer only): " nfsrem
	read -p "Full path to remote directory (press enter for default = /opt/openmpi): " userdir
	nfsdir=${userdir:="/opt/openmpi"}
	mkdir $nfsdir
	echo "pinode$nfsrem.local:$nfsdir $nfsdir    nfs defaults" >> /etc/fstab
	echo "export PATH=$PATH:/opt/openmpi/bin" >> /etc/profile
	echo "/opt/openmpi/lib" >> /etc/ld.so.conf.d/openmpi.conf
	mount -a
	ldconfig
	mpirun --version
	read -p "OpenMPI 4.1.0 - Client install done, press enter to return to menu" input
}

show_mpi_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) install_local;;
	    2) install_server;;
	    3) install_client;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_mpi_menu
	read -p "Select option or x to exit to main menu: " n
done
