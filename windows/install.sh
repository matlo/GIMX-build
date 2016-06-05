#!/bin/bash

PACKAGE_RELEASE="3.0"

pacman --noconfirm -S wget man git make diffutils patch p7zip unzip

if test "$MSYSTEM" = "MINGW32"
then
  ARCH=i686
else
  ARCH=x86_64
fi

pacman --noconfirm -S mingw-w64-$ARCH-pkg-config mingw-w64-$ARCH-gcc mingw-w64-$ARCH-libxml2 mingw-w64-$ARCH-curl mingw-w64-$ARCH-SDL2

mkdir gimx-install
cd gimx-install

wget https://github.com/matlo/GIMX-tools/releases/download/${PACKAGE_RELEASE}/mingw-w64-$ARCH-pdcurses-3.4.0-1-any.pkg.tar.xz
wget https://github.com/matlo/GIMX-tools/releases/download/${PACKAGE_RELEASE}/mingw-w64-$ARCH-wxMSW-2.8.12-1-any.pkg.tar.xz
wget https://github.com/matlo/GIMX-tools/releases/download/${PACKAGE_RELEASE}/mingw-w64-$ARCH-libusb-usbdk-0.0.0-1-any.pkg.tar.xz

pacman --noconfirm -U *.pkg.tar.xz

cd ..
rm -rf gimx-install
