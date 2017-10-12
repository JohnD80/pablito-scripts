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
dir=twrp

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
repo init -u git://github.com/omnirom/android.git -b android-5.1
repo sync --force-sync

# Delete the "old twrp 5.1 recovery and clone the newest version, that in october 2017 is the 8.0 branch)
rm -rf bootable/recovery
git clone https://github.com/omnirom/android_bootable_recovery.git -b android-8.0 bootable/recovery

# Now clone the omni tree for krillin
git clone https://github.com/Pablito2020/android_recovery_bq_krillin.git device/bq/krillin

# Now compile the recovery
. build/envsetup.sh
lunch omni_krillin-userdebug
make -j4 recoveryimage

# Check if the recovery have been succesfully compiled if not then send a message to your phone
# You have to change the line "-data-urlencode phone='ADD YOUR PHONE NUMBER HERE' \ " and change the ADD YOUR PHONE NUMBER HERE words 
# to your phone number.
# Example: --data-urlencode phone='+34 111111111' \
# The prefix (for example +34 for spain, +1 for U.S.A, etc) IS IMPORTANT!
if ! [ -f $OUT/recovery.img ]; then
curl -X POST https://textbelt.com/text \
       --data-urlencode phone='ADD YOUR PHONE NUMBER HERE' \
       --data-urlencode message='Build failed :(' \
       -d key=textbelt
fi
