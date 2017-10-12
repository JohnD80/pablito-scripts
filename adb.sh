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

# Variables
e=echo

# Echo lines
$e "Select what do you want to do:"
$e
$e '############################################ '
$e '#                                          # '
$e '#               SYSTEM TOOLS               # '
$e '#                                          # '
$e '############################################ '
$e
$e "  1 - ADB logcat (Showing everything)"
$e "  2 - ADB logcat showing only  showing warning, error and fatal mesasges"
$e "  3 - ADB logcat showing only showing error and fatal messages"
$e "  4 - ADB logcat only showing fatal messages"
$e "  5 - Debug everything and save it to a file called adb_debug.txt"
$e "  6 - Debug warning, error and fatal mesasges and save it to a file called adb_warning.txt"
$e "  7 - Debug error and fatal messages and save it to a file called adb_error.txt"
$e "  8 - Debug only fatal messages and save it to a file called adb_fatal.txt"
$e
$e '############################################ '
$e '#                                          # '
$e '#               KERNEL TOOLS               # '
$e '#                                          # '
$e '############################################ '
$e
$e "  9 - ADB shell dmesg"
$e "  10 - Make an adb shell dmesg and save it to a file called dmesg.txt"
$e "  11 - Pull the last_kmsg file"
$e
$e '############################################ '
$e '#                                          # '
$e '#               BASIC TOOLS                # '
$e '#                                          # '
$e '############################################ '
$e
$e "  12 - reboot system"
$e "  13 - reboot recovery"
$e "  14 - reboot fastboot (I recomend to use this command only if you have a qcomn device)"
$e "  15 - Check if your device is succesfully connected via adb"
$e "  16 - Make an adb shell"
$e "  x - Exit"
$e
$e -n "Enter Option: "
read o
	case $o in
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
