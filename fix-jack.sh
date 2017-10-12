#!/bin/bash
#
# Fix android compilation errors with the jack/ninja tool 
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
e=echo
ex=export

$e -n "Do you want to disable the jack/ninja building) (Y/N): "
read o
     case $o in
     Y)USE_NINJA=false;;
     y)USE_NINJA=false;;
     N)USE_NINJA=true;;
     n)USE_NINJA=true;;
     *) ERR_MSG="Invalid option!"; clear;;
esac

$ex JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
jack-admin kill-server && jack-admin start-server
