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

# SET COLORS! (SOME OF THEM ARE NOT USED, BUT IF YOU LIKE, YOU CAN ADD IT IN THE ECHO LINES)
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
nocol='\033[0m'
orange='\033[0;33m'
light_red='\033[1;31m'
purple='\033[0;35m'

# SAY INFO ABOUT THE KERNEL AND THE SCRIPT
echo -e "${orange}####################################################"
echo -e "${orange}#                  SCRIPT INFO:                    #"
echo -e "${orange}#             DEVELOPER: PABLITO2020               #"
echo -e "${orange}#       THANKS TO: ASSUSDAN, AND GUYS OF 4PDA      #"
echo -e "${orange}####################################################"

# EXPORT GOOGLE GCC TOOLCHAIN (you can change it if you use another toolchain)
export ARCH=arm    # If your device is arm64 change it to arm64
export CROSS_COMPILE=../arm-eabi-4.8/bin/arm-eabi- # If you want to change your toolchain just change the path

# User and Build Host (You can change it if you like)
export KBUILD_BUILD_USER=Pablito2020
export KBUILD_BUILD_HOST=Daredevil

# READ THE Lineage/AOSP DEFCONFIG (You can change the defconfig from your device)
make lineage_krillin_defconfig

# BUILD ZIMAGE
make -j all zImage

# COMPROBE IF THERE ARE COMPILATION ERRORS AND IF IT HAVE COMPILATION ERRORS SHOW THIS MESSAGE:
if [ ! -f arch/arm/boot/zImage ]
then
    echo -e "${red}############################"
    echo -e "${red}#        BUILD ERROR!      #"
    echo -e "${red}############################"
else

# IF THE KERNEL COMPILES SUCCESFULLY
echo -e "${green} ########################################################"
echo -e "${green} #                  FOR ARM DEVICES:                    #"
echo -e "${green} #           ZIMAGE IS IN ARCH/ARM/BOOT/ZIMAGE          #"
echo -e "${green} #                                                      #"
echo -e "${green} #                 FOR ARM64 DEVICES:                   #"
echo -e "${green} #         ZIMAGE IS IN ARCH/ARM64/BOOT/ZIMAGE          #"
echo -e "${green} #                                                      #"
echo -e "${green} #           HAVE FUN AND GIVE PROPER CREDITS!          #"
echo -e "${green} ########################################################"
fi

# BUILD WORKTIME
echo $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds' 
