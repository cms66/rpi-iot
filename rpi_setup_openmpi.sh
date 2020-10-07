# OpenMPI 4.0.5
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
	wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.5.tar.gz
	tar -xzf openmpi-4.0.5.tar.gz
	cd openmpi-4.0.5
	./configure
	make -j4 all
	make install
	ldconfig
	cd /home/$usrname
	rm -rf openmpi-4.0.5
	rm -rf openmpi-4.0.5.tar.gz
	mpirun --version
	read -p "OpenMPI 4.0.5 - Local install finished, press enter to return to menu" input
}

# 2- Build/install on server
install_server()
{
	read -p "OpenMPI 4.0.5 - Server install TODO, press enter to return to menu" input
}

# 3- Install to run from server
install_client()
{
	read -p "OpenMPI 4.0.5 - Client install TODO, press enter to return to menu" input
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
