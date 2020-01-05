# Menu system for testing hardware in multiple languages

# Variables and arrays for device and language
testdev="0"
testlang="0"
declare -a arrdev=("none" "CSI Camera" "USB Camera" "Sense hat" "Arduino" "GPS" "TFT LCD" "Bluetooth" "Robot arm")
declare -A arrlang=([0]="none" [a]="Python 2" [b]="Python 3" [c]="C" [d]="C++")
usrname=$(whoami)

# Menu for hardware device and test language
show_test_menu()
{
	clear
	printf "Testing menu \n------------\n"
	printf "Set test device \n--------------- \n 1) CSI Camera \n 2) USB Camera \n 3) Sense Hat \n 4) Arduino \n 5) GPS \n 6) TFT LCD \n 7) Bluetooth \n 8) Robot arm \n\n"
	printf "Set test language \n----------------- \n a) Python 2 \n b) Python 3 \n c) C \n d) C++ \n\n"
	printf "Current settings\n----------------\n Device: ${arrdev[$testdev]} \n Lang: ${arrlang[$testlang]} \n\n"
}

# Run test
run_test()
{
	# Check that device and language have been set
	if [ $testdev != "0" ] && [ $testlang != "0" ]; then
		case $testdev in
			1)	case $testlang in
					a)	python /home/$usrname/local/src/python2/test_cam_csi_cap_p2.py #works
						python /home/$usrname/local/src/python2/test_cam_csi_vid_p2.py #works
						read -p "test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - completed (image and video) - press any key to continue" runtest;;
					b)	python3 /home/$usrname/local/src/python3/test_cam_csi_cap_p3.py #works
						python3 /home/$usrname/local/src/python3/test_cam_csi_vid_p3.py #works
						read -p "test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - completed (image and video) - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;			
			2)	case $testlang in
					a)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					b)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;
			3)	case $testlang in
					a)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					b)	python3 /home/$usrname/local/src/python3/test_sensehat_p3.py #works
						read -p "test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - completed - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;
			4)	case $testlang in
					a)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					b)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;
			5)	case $testlang in
					a)	python2 /home/$usrname/local/src/python2/test_gps_p2.py #works
						read -p "test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - completed - press any key to continue" runtest;;
					b)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;
			6)	case $testlang in
					a)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					b)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;
			7)	case $testlang in
					a)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					b)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;
			8)	case $testlang in
					a)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					b)	python3 /home/$usrname/local/src/python3/test_arm_p3.py #works
						read -p "test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - completed - press any key to continue" runtest;;
					c)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
					d)	read -p "TODO - test ${arrdev[$testdev]} in ${arrlang[$testlang]} language - press any key to continue" runtest;;
				esac;;
		esac
	else
		read -p "device or language have not been set - press any key to continue" runtest
	fi
}

show_test_menu
read -p "Select device/language, r to run test or x to exit: " usrchoice
while [ $usrchoice != "x" ]; do
	case $usrchoice in
	    [1-8]) testdev=$usrchoice;;
	    [a-d]) testlang=$usrchoice;;
	    r) run_test;;
	    *) read -p "invalid option - press any to continue" errkey;;
	esac
	show_test_menu
	read -p "Select device/language, r to run test or x to exit: " usrchoice
done
