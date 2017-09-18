#!/bin/bash
# Script for execute the adb logcat command

echo '############################################ '
echo '#                                          # '
echo '#  SEARCHING IF YOUR DEVICE IS CONNECTED   # '
echo '#                                          # '
echo '############################################ '

# ADB DEVICES
adb devices

echo "Select the type of debbuging you want for:"
echo
echo "  1 - Debug everything"
echo "  2 - Debug warning, error and fatal mesasges"
echo "  3 - Debug error and fatal messages"
echo "  4 - Debug only fatal messages"
echo
echo "  x - Exit"
echo
echo -n "Enter Option: "
read opt
	case $opt in
		1) adb logcat; break;;
		2) adb logcat ; break;;
		x) clear; echo; echo "Goodbye."; echo; exit 1;;
		*) ERR_MSG="Invalid option!"; clear;;
	esac
done
