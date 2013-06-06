#!/bin/bash

#
# Warning: changing the version will clean the sources and remove the setup directory!!!!
#
VERSION=$1
OLDVERSION=$(grep INFO_VERSION GIMX/info.h 2> /dev/null | sed "s/#define[ ]*INFO_VERSION[ ]*//" | sed "s/\"//g")

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

if [ -n "$VERSION" ]
then
  MAJOR=$(echo $VERSION | awk -F"." '{print $1}')
  MINOR=$(echo $VERSION | awk -F"." '{print $2}')
  echo Major release number: $MAJOR
  echo Minor release number: $MINOR
  if [ -z $MAJOR ] || [ -z $MINOR ]
  then
    echo Invalid release number!
    exit
  fi
  
  sed -i "s/FILEVERSION[ ]*[0-9]*,[0-9]*,[0-9]*,[0-9]*/FILEVERSION   $MAJOR,$MINOR,0,0/" GIMX/*/*.rc
  sed -i "s/PRODUCTVERSION[ ]*[0-9]*,[0-9]*,[0-9]*,[0-9]*/PRODUCTVERSION  $MAJOR,$MINOR,0,0/" GIMX/*/*.rc
  sed -i "s/[ ]*VALUE[ ]*\"FileVersion\",[ ]*\"[0-9]*.[0-9]*\"/    VALUE \"FileVersion\", \"$MAJOR.$MINOR\"/" GIMX/*/*.rc
  sed -i "s/[ ]*VALUE[ ]*\"ProductVersion\",[ ]*\"[0-9]*.[0-9]*\"/    VALUE \"ProductVersion\", \"$MAJOR.$MINOR\"/" GIMX/*/*.rc
  
  sed -i "s/#define[ ]*INFO_VERSION[ ]*\"[0-9]*.[0-9]*\"/#define INFO_VERSION \"$MAJOR.$MINOR\"/" GIMX/info.h
  sed -i "s/#define[ ]*INFO_YEAR[ ]*\"2010-[0-9]*\"/#define INFO_YEAR \"2010-$(DATE '+%Y')\"/" GIMX/info.h
  
  sed -i "s/#define[ ]*MyAppVersion[ ]*\"[0-9]*.[0-9]*\"/#define MyAppVersion \"$MAJOR.$MINOR\"/" inno.iss
fi

cd GIMX

if [ -n "$VERSION" ] && [ "$VERSION" != "$OLDVERSION" ]
then
  echo Version changed: clean before build.
  make clean
  rm -rf setup
fi

make -j $CPU install

cd ..

if [ -n "$VERSION" ]
then
  if [ "$PROCESSOR_ARCHITEW6432" == "AMD64" ]
  then
    /c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe inno.iss
  else
    /c/Program\ Files/Inno\ Setup\ 5/ISCC.exe inno.iss
  fi
fi
