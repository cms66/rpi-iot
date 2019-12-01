# NFS
# 
show_nfs_menu()
{
	clear
	echo "NFS setup menu \n----------"
	echo "select setup option or x to exit \n 1) Setup local Server \n 2) Add local export \n 3) Add Remote mount \n"
}

# Setup local Server
# Creates default share /var/nfs-export + local mount
setup_local_server()
{
	apt-get -y install nfs-kernel-server
	tar -xvzf /boot/nfs-export.tgz -C /var/
	mkdir /home/$usrname/share$pinum
	chown $usrname.$usrname /home/$usrname/share$pinum
	echo "/var/nfs-export 192.168.0.0/255.255.255.0(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
	echo "/var/nfs-export /home/$usrname/share$pinum    none	bind	0	0" >> /etc/fstab
	exportfs -ra
	mount -a
	read -p "NFS Server setup done, press enter to return to menu" input
}

# Add local export
add_local_export()
{
	read -p "NFS local export TODO, press enter to return to menu" input
}

# Add remote mount
add_remote_mount()
{
	read -p "Remote node (integer only): " nfsrem
	read -p "Remote directory (default = /var/nfs-export): " nfsdir
	if [-z $nfsdir]
	then
		$nfsdir = "/var/nfs-export"
	fi
	mkdir /home/$usrname/share$nfsrem
	chown $usrname.$usrname /home/$usrname/share$nfsrem
	echo "pinode$nfsrem.local:$nfsdir /home/$usrname/share$nfsrem    nfs defaults" >> /etc/fstab
	mount -a
	read -p "NFS remote mount done, press enter to return to menu" input
}

read -p "Networking - Which node in Pi cluster are you? - integer only: " pinum
show_nfs_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) setup_local_server;;
	    2) add_local_export;;
	    3) add_remote_mount;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_nfs_menu
	read -p "Select option or x to exit to main menu: " n
done



