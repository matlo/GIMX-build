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
  wget http://diyps3controller.googlecode.com/files/svn-win32-$SVN_VERSION.zip
  unzip -u -d /usr/local/ svn-win32-$SVN_VERSION.zip
  rm -rf svn-win32-$SVN_VERSION svn-win32-$SVN_VERSION.zip
fi

#checkout & compile GIMX
if ! test -d GIMX
then
  svn checkout http://diyps3controller.googlecode.com/svn/trunk/GIMX
fi

cd GIMX
make -f Makefile.win -j $CPU install
