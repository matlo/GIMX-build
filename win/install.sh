#!/bin/bash

PREFIX=/mingw
WXMSW=wxMSW-2.8.12
SDL=SDL-1.2.14
ZLIB=1.2.3

#install required tools/librairies
test -f /bin/patch || mingw-get install msys-patch
test -f /bin/wget || mingw-get install msys-wget
test -f /bin/unzip || mingw-get install msys-unzip
test -f $PREFIX/bin/iconv.h || mingw-get install mingw32-libiconv

if ! test -f cpu
then
  wget http://diyps3controller.googlecode.com/svn/trunk/build/win/cpu.c
  gcc -o cpu cpu.c
  rm cpu.c
fi

if ! test $1 = "sources"
then
  wget http://diyps3controller.googlecode.com/files/GIMX-libs-dev.tar.gz
  tar --strip-components=1 -C $PREFIX -xzvf GIMX-libs-dev.tar.gz
  rm -rf GIMX-libs-dev GIMX-libs-dev.tar.gz
else  
  CPU=$(./cpu)
  
  #build the SDL library
  if ! test -f $PREFIX/bin/SDL.dll
  then
    wget http://www.libsdl.org/release/$SDL.tar.gz
    tar xzvf $SDL.tar.gz
    wget http://diyps3controller.googlecode.com/svn/trunk/libsdl/patch.win
    cd $SDL
    patch -p1 < ../patch.win
    ./configure --enable-stdio-redirect=no --prefix=$PREFIX
    make -j $CPU
    make install
    cd ..
    rm -rf $SDL.tar.gz patch.win $SDL
  fi

  #build wxWidgets
  if ! test -f $PREFIX/lib/libwx_baseu-*
  then
    wget http://prdownloads.sourceforge.net/wxwindows/$WXMSW.zip
    unzip $WXMSW.zip
    cd $WXMSW
    mkdir msw-gimx
    cd msw-gimx
    ../configure --disable-shared --enable-unicode --prefix=$PREFIX
    make -j $CPU
    make install
    cd ../..
    rm -rf $WXMSW $WXMSW.zip
  fi

  #Get libxml
  if ! test -f $PREFIX/bin/libxml2.dll
  then
    mkdir libxml
    cd libxml
    wget http://sourceforge.net/projects/devpaks/files/libxml2/LibXML2%20-%202.6.27/libxml2-2.6.27-1cm.DevPak/download
    tar xjvf libxml2-2.6.27-1cm.DevPak
    cp bin/* $PREFIX/bin
    cp -r include/libxml $PREFIX/include
    cp lib/* $PREFIX/lib
    cd ..
    rm -rf libxml
  fi

  #Get zlib
  if ! test -f $PREFIX/bin/zlib1.dll
  then
    mkdir zlib
    cd zlib
    wget http://sourceforge.net/projects/gnuwin32/files/zlib/$ZLIB/zlib-$ZLIB-bin.zip/download
    unzip zlib-$ZLIB-bin.zip
    cp bin/zlib1.dll $PREFIX/bin
    cd ..
    rm -rf zlib
  fi
fi

