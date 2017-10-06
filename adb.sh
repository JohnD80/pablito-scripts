#!/bin/bash
#
# Script for an easier adb logcat experience
# Copyright (C) 2017 Pablo Fraile Alonso (Github aka: Pablito2020)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

# Echo lines
echo "Select what do you want to do:"
echo
echo '############################################ '
echo '#                                          # '
echo '#               SYSTEM TOOLS               # '
echo '#                                          # '
echo '############################################ '
echo
echo "  1 - ADB logcat (Showing everything)"
echo "  2 - ADB logcat showing only  showing warning, error and fatal mesasges"
echo "  3 - ADB logcat showing only showing error and fatal messages"
echo "  4 - ADB logcat only showing fatal messages"
echo "  5 - Debug everything and save it to a file called adb_debug.txt"
echo "  6 - Debug warning, error and fatal mesasges and save it to a file called adb_warning.txt"
echo "  7 - Debug error and fatal messages and save it to a file called adb_error.txt"
echo "  8 - Debug only fatal messages and save it to a file called adb_fatal.txt"
echo
echo '############################################ '
echo '#                                          # '
echo '#               KERNEL TOOLS               # '
echo '#                                          # '
echo '############################################ '
echo
echo "  9 - ADB shell dmesg"
echo "  10 - Make an adb shell dmesg and save it to a file called dmesg.txt"
echo "  11 - Pull the last_kmsg file"
echo
echo '############################################ '
echo '#                                          # '
echo '#               BASIC TOOLS                # '
echo '#                                          # '
echo '############################################ '
echo
echo "  12 - reboot system"
echo "  13 - reboot recovery"
echo "  14 - reboot fastboot (I recomend to use this command only if you have a qcomn device)"
echo "  15 - Check if your device is succesfully connected via adb"
echo "  16 - Make an adb shell"
echo "  x - Exit"
echo
echo -n "Enter Option: "
read opt
	case $opt in
		1) adb logcat;;
		2) adb logcat *:W;;
		3) adb logcat *:E;;
		4) adb logcat *:F;;
		5) adb logcat > adb_debug.txt;;
		6) adb logcat *:W > adb_warning.txt;;
		7) adb logcat *:E > adb_error.txt;;
		8) adb logcat *:F > adb_fatal.txt;;
                9) adb shell dmesg;;
                10) adb shell dmesg > dmesg.txt;;
                11) adb pull proc/last_kmsg2;;
                12) adb reboot;;
                13) adb reboot recovery;;
                14) adb reboot-bootloader;;
                15) adb devices;;
                16) adb shell;;
		x) clear; echo; echo "Goodbye."; echo; exit 1;;
		*) ERR_MSG="Invalid option!"; clear;;
	esac
