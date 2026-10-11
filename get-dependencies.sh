#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cdparanoia     \
    fdkaac         \
    gdk-pixbuf2    \
    intltool       \
    libcddb        \
    mac            \
    musepack-tools \
    opus-tools     \
    vorbis-tools   \
    wavpack

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano gtk2-mini

# Comment this out if you need an AUR package
#make-aur-package asunder

echo "Building stable version of Asunder..."
echo "---------------------------------------------------------------"
VERSION=3.0.2
wget http://littlesvr.ca/asunder/releases/asunder-${VERSION}.tar.bz2
echo "$VERSION" > ~/version

tar -xvf asunder-${VERSION}.tar.bz2 && rm ./*.tar.bz2
cd ./asunder-${VERSION}
./configure --prefix=/usr
make -j$(nproc) install
