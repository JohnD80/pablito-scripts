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

echo '############################################ '
echo '#                                          # '
echo '#            ADB LOGCAT SCRIPT             # '
echo '#  YOU MUST HAVE THE ADB DRIVER INSTALLED  # '
echo '#            FOR MAKE IT WORK              # '
echo '#                                          # '
echo '############################################ '

# Check if the device is connected
adb devices

echo "Select the type of debbuging you want for:"
echo
echo "  1 - Debug everything"
echo "  2 - Debug warning, error and fatal mesasges"
echo "  3 - Debug error and fatal messages"
echo "  4 - Debug only fatal messages"
echo "  5 - Debug everything and save it to a file called adb_debug.txt"
echo "  6 - Debug warning, error and fatal mesasges and save it to a file called adb_warning.txt"
echo "  7 - Debug error and fatal messages and save it to a file called adb_error.txt"
echo "  8 - Debug only fatal messages and save it to a file called adb_fatal.txt"
echo
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
		x) clear; echo; echo "Goodbye."; echo; exit 1;;
		*) ERR_MSG="Invalid option!"; clear;;
	esac
done
