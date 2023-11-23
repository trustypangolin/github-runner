#!/bin/bash
### every exit != 0 fails the script
set -e

arch=$(uname -m)
if [ "$arch" == x86_64* ]; then
    echo "X64 Architecture"
    apt-get -yq install git rsync locales

elif [ "$arch" == arm* ] || [ $arch = aarch64 ]; then
    echo "ARM Architecture"
    apt-get -yq install git rsync locales
fi