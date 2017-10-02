#!/bin/bash
#
# Script for setup the global envoirment for the Daredevil kernel
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

# Run the terminal as root
sudo su

# Setup the global enviorment (necessary for build android libraries)
sudo apt-get install git
sudo apt-get remove openjdk-* icedtea-* icedtea6-*
sudo apt-get install git ccache automake lzop bison gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libbz2-1.0 libghc-bzlib-dev squashfs-tools pngcrush schedtool dpkg-dev liblz4-tool make optipng maven
sudo apt-get install repo


# Say what branch do you want to build?
echo
  echo "Select what Daredevil branch do you want to build:"
  echo
  echo "  1 - Daredevil-MM (cm-13.0 branch)"
  echo "  2 - Daredevil-N (cm-14.1 branch)"
  echo "  x - Exit"
  echo
  echo -n "Enter Option: "
read opt

	case $opt in
		1) git clone https://github.com/Pablito2020/android_kernel_bq_krillin.git -b cm-13.0; break;;
		2) git clone https://github.com/Pablito2020/android_kernel_bq_krillin.git -b cm-14.1; break;;
		x) clear; echo; echo "Goodbye."; echo; exit 1;;
		*) ERR_MSG="Invalid option!"; clear;;
esac

# Rename the git project to daredevil
mv android_kernel_bq_krillin Daredevil-Kernel

# Enter to the Daredevil kernel
cd Daredevil-Kernel

# Finally Run the Build Script 
. daredevil.sh
