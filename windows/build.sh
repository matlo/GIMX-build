#!/bin/bash

#
# Warning: changing the version will clean the sources and remove the setup directory!!!!
#
VERSION=$1
OLDVERSION=$(grep INFO_VERSION GIMX/info.h 2> /dev/null | sed "s/#define[ ]*INFO_VERSION[ ]*//" | sed "s/\"//g")
BRANCH="master"

if test -f cpu
then
  CPU=$(./cpu)
else
  CPU=1
fi

#checkout & compile GIMX
if ! test -d GIMX
then
  git clone -b $BRANCH --single-branch --depth 1 https://github.com/matlo/GIMX.git
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
  if [ "$MSYSTEM" == "MINGW32" ]
  then
    sed -i "s/[; ]*ArchitecturesInstallIn64BitMode/; ArchitecturesInstallIn64BitMode/" -i inno.iss
  else
    sed -i "s/[; ]*ArchitecturesInstallIn64BitMode/ArchitecturesInstallIn64BitMode/" -i inno.iss
  fi
  if test -f /c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe
  then
    /c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe inno.iss
  else
    /c/Program\ Files/Inno\ Setup\ 5/ISCC.exe inno.iss
  fi
  if [ "$MSYSTEM" == "MINGW32" ]
  then
    mv gimx-$VERSION.exe gimx-$VERSION-i686.exe
  else
    mv gimx-$VERSION.exe gimx-$VERSION-x86_64.exe
  fi
fi
