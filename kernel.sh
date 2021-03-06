#!/bin/bash
#
# Script for building the kernel source
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
e=echo
m=make
ex=export

# Say Info
$e -e "${orange}####################################################"
$e -e "${orange}#                  SCRIPT INFO:                    #"
$e -e "${orange}#             DEVELOPER: PABLITO2020               #"
$e -e "${orange}#       THANKS TO: ASSUSDAN, AND GUYS OF 4PDA      #"
$e -e "${orange}####################################################"

# If the google toolchain 4.8 doesn't exist clone it.
if [ ! -f ../arm-eabi-4.8/bin/arm-eabi-addr2line ]
then
cd ..
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
else
$ex ARCH=arm    # If your device is arm64 change it to arm64
$ex CROSS_COMPILE=../arm-eabi-4.8/bin/arm-eabi- # If you want to change your toolchain just change the path
fi

# User and Build Host (You can change it if you like)
$ex KBUILD_BUILD_USER=Pablito2020
$ex KBUILD_BUILD_HOST=Daredevil

# Read the defconfig file (You can change the defconfig from your device)
$m lineage_krillin_defconfig

# Build zImage
$m -j all zImage

# Comprobe if there were compilation errors 
if [ ! -f arch/arm/boot/zImage ] # If your device is arm64 change arm to arm64
then
    $e -e "${red}############################"
    $e -e "${red}#        BUILD ERROR!      #"
    $e -e "${red}############################"
else

# Success message
$e -e "${green} ########################################################"
$e -e "${green} #                  FOR ARM DEVICES:                    #"
$e -e "${green} #           ZIMAGE IS IN ARCH/ARM/BOOT/ZIMAGE          #"
$e -e "${green} #                                                      #"
$e -e "${green} #                 FOR ARM64 DEVICES:                   #"
$e -e "${green} #         ZIMAGE IS IN ARCH/ARM64/BOOT/ZIMAGE          #"
$e -e "${green} #                                                      #"
$e -e "${green} #           HAVE FUN AND GIVE PROPER CREDITS!          #"
$e -e "${green} ########################################################"
fi

# Worktime
$e $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds' 
