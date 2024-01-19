# OpenMPI 4.1.2
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
	wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.2.tar.gz
	tar -xzf openmpi-4.1.2.tar.gz
	cd openmpi-4.1.2
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
	read -p "OpenMPI 4.1.2 - Local install finished, press enter to return to menu" input
}

# 2- Build/install on server
# TODO - check for existing export of /usr/local
install_server()
{
	cd /home/$usrname
	wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.2.tar.gz
	tar -xzf openmpi-4.1.2.tar.gz
	cd openmpi-4.1.2
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
	echo "/usr/local 192.168.0.0/255.255.255.0(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
	exportfs -ra
	ldconfig
	cd /home/$usrname
	rm -rf openmpi*
	mpirun --version
	read -p "OpenMPI 4.1.2 - Server install finished, press enter to return to menu" input
}

# 3- Install to run from server
# TODO - Check for existing mount of /usr/local
install_client()
{
	read -p "Remote node (integer only): " nfsrem
	read -p "Full path to remote directory (press enter for default = /usr/local): " userdir
	nfsdir=${userdir:="/usr/local"}
	mkdir -p $nfsdir
	echo "pinode$nfsrem.local:$nfsdir $nfsdir    nfs defaults" >> /etc/fstab
	mount -a
 	#systemctl daemon-reload
	ldconfig
	mpirun --version
	read -p "OpenMPI 4.1.2 - Client install done, press enter to return to menu" input
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
