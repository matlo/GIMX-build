#!/bin/bash

VERSION=`cat version`
DATE=`date -R`
BRANCH="master"

echo "Version number? (default: "$VERSION")"

read NEW_VERSION

if [ -z $NEW_VERSION ]
then
  NEW_VERSION=$VERSION
fi

if [ -z $NEW_VERSION ]
then
  echo No version specified!
  exit
fi

echo $NEW_VERSION > version

if test -f cpu
then
  CPU=$(./cpu)
else
  CPU=1
fi

#checkout & compile GIMX
echo Clean previous build.
rm -rf GIMX
git clone -b $BRANCH --single-branch --depth 1 https://github.com/matlo/GIMX.git

MAJOR=$(echo $NEW_VERSION | awk -F"." '{print $1}')
MINOR=$(echo $NEW_VERSION | awk -F"." '{print $2}')
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

cd GIMX
make -j $CPU install
cd ..

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
  mv gimx-$NEW_VERSION.exe gimx-$NEW_VERSION-i386.exe
else
  mv gimx-$NEW_VERSION.exe gimx-$NEW_VERSION-x86_64.exe
fi
