#!/bin/bash

pacman --noconfirm -S man git make diffutils patch p7zip unzip

if test "$MSYSTEM" = "MINGW32"
then
  ARCH=i686
else
  ARCH=x86_64
fi

pacman --noconfirm -S mingw-w64-$ARCH-gcc mingw-w64-$ARCH-SDL2 mingw-w64-$ARCH-libxml2 mingw-w64-$ARCH-curl

mkdir gimx-install
cd gimx-install

wget https://github.com/matlo/GIMX-tools/releases/download/1.0/mingw-w64-$ARCH-libusb-1.0.18-1-any.pkg.tar.xz
wget https://github.com/matlo/GIMX-tools/releases/download/1.0/mingw-w64-$ARCH-pdcurses-3.4.0-1-any.pkg.tar.xz
wget https://github.com/matlo/GIMX-tools/releases/download/1.0/mingw-w64-$ARCH-wxMSW-2.8.12-1-any.pkg.tar.xz

pacman --noconfirm -U *.pkg.tar.xz

wget https://raw.githubusercontent.com/matlo/GIMX-tools/master/MINGW-packages/patches/hidsdi.h.patch
wget https://raw.githubusercontent.com/matlo/GIMX-tools/master/MINGW-packages/patches/hidclass.h.patch

patch -d /$MSYSTEM/$ARCH-w64-$MSYSTEM/include -p0 < hidsdi.h.patch
patch -d /$MSYSTEM/$ARCH-w64-$MSYSTEM/include/ddk -p0 < hidclass.h.patch

cd ..
rm -rf gimx-install
