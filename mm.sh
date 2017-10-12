#!/bin/bash
#
# Script for building lineage os 13.0 for krillin, you can adapt it to your device
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
dir=lineage-13.0
e=echo

# Say info about what are you building on bash!
$e -e "${orange}####################################################"
$e -e "${orange}#                                                  #"
$e -e "${orange}#      PABLITO2020 LINEAGE OS 13.0 BUILD SCRIPT    #"
$e -e "${orange}#                                                  #"
$e -e "${orange}####################################################"
$e -e "${orange}#                                                  #"
$e -e "${orange}#                  BUILD INFO:                     #"
$e -e "${orange}#             DEVICE: BQ AQUARIS E4.5              #"
$e -e "${orange}#            LINEAGE OS VERSION: 13.0              #"
$e -e "${orange}#            ANDROID OS VERSION: 6.0.1             #"
$e -e "${orange}#          LINUX KERNEL VERSION: 3.10.XX           #"
$e -e "${orange}#                                                  #"
$e -e "${orange}####################################################"
$e -e "${orange}#                                                  #"
$e -e "${orange}#                  SCRIPT INFO:                    #"
$e -e "${orange}#             DEVELOPER: PABLITO2020               #"
$e -e "${orange}#                                                  #"
$e -e "${orange}####################################################" 

# Check if the repo tool is installed, if it isn't installed then install it.
if ! [ -f /bin/repo ]; then
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
fi

# Create a Lineage os directory
mkdir $dir
cd $dir

# Initialize the Lineage os 13.0 repo
repo init -u git://github.com/LineageOS/android.git -b cm-13.0

# Repo sync with force sync for the people who have a poor internet conection:
repo sync --force-sync

# Clone the krillin necessary repos
git clone https://github.com/Pablito2020/android_device_bq_krillin.git -b cm13.0 device/bq/krillin

git clone https://github.com/Pablito2020/android_kernel_bq_krillin.git -b cm-13.0 kernel/bq/krillin

git clone https://github.com/Pablito2020/android_vendor_bq_krillin.git -b cm-13.0 vendor/bq/krillin

git clone https://github.com/LineageOS/android_external_stlport.git -b cm-13.0 external/stlport


# Initialize the build command
. build/envsetup.sh

# Lunch for see the aviable devices in the Lineage os Repo
lunch

# Use ccache for a fastest build
export USE_CCACHE=1
export CCACHE_DIR=./.ccache
ccache -M 50G

# Select krillin
lineage_krillin-userdebug

# Now build with ccache
ccache make -j4

# Check if the build failed and if it fialed send a message to my phone (THE MESSAGE IS ONLY AVIABLE ONCE PER DAY)
# Add your phone number with a prefix, for example in spain +34 and now the telephone number
# Example: +34 111 111 111
if ! [ -f $OUT/system.img ]; then
curl -X POST https://textbelt.com/text \
       --data-urlencode phone='ADD YOUR PHONE NUMBER HERE' \
       --data-urlencode message='Build failed :(' \
       -d key=textbelt
fi

# If build was compiled succesfully then power off the computer
sudo halt
