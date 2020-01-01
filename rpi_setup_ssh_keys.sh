# Setup SSH Private/Public keys (required for MPI)
#
show_ssh_key_menu()
{
	clear
	printf "SSH Private/Public key setup menu \n----------------\n"
	printf "select setup option or x to exit \n 1) Remove keys on server \n 2) Create keys on server \n 3) Add client \n 4) Add host to Server \n"
}

# 1- Remove keys on server
remove_server_keys()
{
	rm -f /etc/ssh/ssh_host_*
	echo "Default server keys removed from /etc/ssh \n"
	read -p "Server keys removed, press enter to return to menu" input
}

# 2 - Generate keys on MPI server - run once
# - TODO
# -- Modify /etc/ssh/sshd_config to use new keys **
# -- Check for existing keys
# -- Read hostname
# -- Give options for rsa/dsa/ecdsa
create_server_keys()
{
	# Create keys for user
	mkdir -p /home/$usrname/.ssh
	ssh-keygen -q -b 521 -t ecdsa -f /home/$usrname/.ssh/id_ecdsa -P ""
	chown -R $usrname.$usrname /home/$usrname/.ssh
	sed -i "s/root@/$usrname@/g" /home/$usrname/.ssh/id_ecdsa.pub
	# Modify SSHD config to use created keys
	echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
	echo "HostKey /home/$usrname/.ssh/id_ecdsa" >> /etc/ssh/sshd_config
	read -p "Server keys generated for $usrname, press enter to return to menu" input
}

# 3 - Add client to server hosts file
add_host_to_server()
{
	# Add host to server hosts file
	read -p "Which node in Pi cluster do you want to add? - integer only: " clientnum
	read -p "IP address: " clientip
	echo "$clientip  pinode$clientnum.local pinode$clientnum" >> /etc/hosts
}

# 4 - Share pub key with client
add_client()
{
	# Setup SSH/ECDSA keys on client
	read -p "Which node in Pi cluster do you want to share pub key with? - integer only: " clientnum	
	ssh-copy-id -i /home/$usrname/.ssh/id_ecdsa.pub $usrname@pinode$clientnum.local
	#cat /home/$usrname/.ssh/id_ecdsa.pub | ssh $usrname@pinode$clientnum.local "mkdir -p /home/$usrname/.ssh && chmod 700 /home/$usrname/.ssh && cat >> /home/$usrname/.ssh/authorized_keys"
	read -p "$usrname@pinode$clientnum.local ($clientip) setup done, press any key to continue" input
}

show_ssh_key_menu
read -p "Select option or x to exit to main menu: " n
while [ $n != "x" ]; do
	case $n in
	    1) remove_server_keys;;
	    2) create_server_keys;;
	    3) add_client;;
	    4) add_host_to_server;;
	    *) read -p "invalid option - press enter to continue" errkey;;
	esac
	show_ssh_key_menu
	read -p "Select option or x to exit to main menu: " n
done