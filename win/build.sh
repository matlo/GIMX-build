#!/bin/bash

if test -f cpu
then
  CPU=$(./cpu)
else
  CPU=1
fi
PREFIX=/mingw
SVN_VERSION=1.6.17

#install svn
if ! test -f /usr/local/bin/svn.exe
then
  wget http://www.gimx.fr/archive/svn-win32-$SVN_VERSION.zip
  unzip -u -d /usr/local/ svn-win32-$SVN_VERSION.zip
  rm -rf svn-win32-$SVN_VERSION svn-win32-$SVN_VERSION.zip
fi

#checkout & compile GIMX
if ! test -d GIMX
then
  mkdir -p GIMX
  cd GIMX
  svn checkout http://diyps3controller.googlecode.com/svn/trunk/sixaxis-emu
  svn checkout http://diyps3controller.googlecode.com/svn/trunk/sixaxis-emu-configurator
  svn checkout http://diyps3controller.googlecode.com/svn/trunk/sixemugui-serial
  svn checkout http://diyps3controller.googlecode.com/svn/trunk/sixstatus
  svn checkout http://diyps3controller.googlecode.com/svn/trunk/fpsconfig
  svn export http://diyps3controller.googlecode.com/svn/trunk/Makefile.win
  cd ..
fi

cd GIMX
make -f Makefile.win -j $CPU install

