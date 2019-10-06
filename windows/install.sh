#!/bin/bash

PACKAGE_RELEASE="v8"

if test "$MSYSTEM" = "MINGW32"
then
  ARCH=i686
else
  ARCH=x86_64
fi

pacman --needed --noconfirm -S git

pacman --needed --noconfirm -S base-devel

pacman --needed --noconfirm -S p7zip unzip

pacman --needed --noconfirm -S mingw-w64-$ARCH-toolchain

pacman --needed --noconfirm -S \
  mingw-w64-$ARCH-ntldd \
  mingw-w64-$ARCH-libxml2 \
  mingw-w64-$ARCH-curl \
  mingw-w64-$ARCH-wxWidgets \
  mingw-w64-$ARCH-ncurses

mkdir gimx-install
cd gimx-install

wget https://github.com/matlo/GIMX-MINGW-packages/releases/download/${PACKAGE_RELEASE}/mingw-w64-$ARCH-SDL2-2.0.10-1-any.pkg.tar.zst
wget https://github.com/matlo/GIMX-MINGW-packages/releases/download/${PACKAGE_RELEASE}/mingw-w64-$ARCH-avrdude-6.3-1-any.pkg.tar.zst
wget https://github.com/matlo/GIMX-MINGW-packages/releases/download/${PACKAGE_RELEASE}/mingw-w64-$ARCH-libusb-1.0.23-1-any.pkg.tar.zst

pacman --needed --noconfirm -U *.pkg.tar.zst

cd ..
rm -rf gimx-install
