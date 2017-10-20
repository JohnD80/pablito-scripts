#!/bin/bash
#
# Script for building twrp for krillin, you can adapt it to your device
#
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
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
nocol='\033[0m'
orange='\033[0;33m'
light_red='\033[1;31m'
purple='\033[0;35m'
OUT=$CURR_DIR/out/target/product/krillin
dir=cm-twrp

# Install/check/update repo command:
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Create a twrp folder
mkdir $dir
cd $dir

# Initialize the 5.1 omnirom repo (I used that because the krillin device tree is only adapted for 5.1)
# You can change it if you like
repo init -u git://github.com/LineageOS/android.git -b cm-14.1
repo sync --force-sync

# Add TWRP comaptibility to the lineage os source
git clone https://github.com/LineageOS/android_external_busybox external/busybox
git clone https://github.com/OmniROM/android_bootable_recovery bootable/recovery-twrp

# Now clone the device tree for krillin
git clone https://github.com/Pablito2020/android_device_bq_krillin.git -b cm-14.1

# Now compile the recovery
. build/envsetup.sh
