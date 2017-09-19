#!/bin/bash
# Build Script for build Lineage os for krillin
# Created by Pablo Fraile Alonso, AKA Pablito2020
# If you use it please give credits!
# Now we are good to go on!

# FIRST OF ALL GET ROOT ACCESS!
sudo su

# Set colors (SOME OF THEM ARE NOT USED, BUT IF YOU LIKE, YOU CAN ADD IT IN THE ECHO LINES)
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
nocol='\033[0m'
orange='\033[0;33m'
light_red='\033[1;31m'
purple='\033[0;35m'

# Say info about what are you building on bash!
echo -e "${orange}####################################################"
echo -e "${orange}#                                                  #"
echo -e "${orange}#      PABLITO2020 LINEAGE OS 13.0 BUILD SCRIPT    #"
echo -e "${orange}#                                                  #"
echo -e "${orange}####################################################"
echo -e "${orange}#                                                  #"
echo -e "${orange}#                  BUILD INFO:                     #"
echo -e "${orange}#             DEVICE: BQ AQUARIS E4.5              #"
echo -e "${orange}#            LINEAGE OS VERSION: 13.0              #"
echo -e "${orange}#            ANDROID OS VERSION: 6.0.1             #"
echo -e "${orange}#          LINUX KERNEL VERSION: 3.10.XX           #"
echo -e "${orange}#                                                  #"
echo -e "${orange}####################################################"
echo -e "${orange}#                                                  #"
echo -e "${orange}#                  SCRIPT INFO:                    #"
echo -e "${orange}#             DEVELOPER: PABLITO2020               #"
echo -e "${orange}#                                                  #"
echo -e "${orange}####################################################" 

# Install the repo command:
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Create a Lineage os directory
mkdir Lineage-nougat
cd Lineage-nougat

# Specify out directory
OUT=$CURR_DIR/out/target/product/krillin

# Initialize the Lineage os 14.1 repo
repo init -u git://github.com/LineageOS/android.git -b cm-13.0

# Repo sync with force sync for the people who have a poor internet conection:
repo sync --force-sync

# Clone the krillin necessary repos
# Device tree
cd device
mkdir bq
cd bq
git clone https://github.com/Pablito2020/android_device_bq_krillin.git -b cm13.0
mv android_device_bq_krillin krillin
cd ../..
# Kernel source:
mkdir kernel
cd kernel
mkdir bq
cd bq
git clone https://github.com/Pablito2020/android_kernel_bq_krillin.git -b cm-13.0
mv android_kernel_bq_krillin krillin
cd ../..
# Vendor blobs:
cd vendor
mkdir bq
cd bq
git clone https://github.com/Pablito2020/android_vendor_bq_krillin.git -b cm-13.0
mv android_vendor_bq_krillin krillin
cd ../..
# EGL necessary files:
cd external
git clone https://github.com/LineageOS/android_external_stlport.git -b cm-13.0
mv android_external_stlport stlport
cd ..

# Apply mtk source patches for krillin:
#cd device/bq/krillin/patches
#. apply-patches.sh

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

# Now build with ccache :)
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

