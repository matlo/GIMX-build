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
git clone -b $BRANCH --single-branch --depth 1 --recursive https://github.com/matlo/GIMX.git

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

make -C GIMX -j $CPU install

TOOLS_DIR="tools"

#
# UsbDk driver
#

TOOLS_USBDK_DIR="$TOOLS_DIR/usbdk"

USBDK_VERSION="1.0.19"
USBDK_MSI_X64="UsbDk_${USBDK_VERSION}_x64.msi"
USBDK_MSI_X86="UsbDk_${USBDK_VERSION}_x86.msi"

mkdir -p $TOOLS_USBDK_DIR

if ! test -f $TOOLS_USBDK_DIR/$USBDK_MSI_X64
then
  wget http://www.spice-space.org/download/windows/usbdk/$USBDK_MSI_X64 -O $TOOLS_USBDK_DIR/$USBDK_MSI_X64
fi

if ! test -f $TOOLS_USBDK_DIR/$USBDK_MSI_X86
then
  wget http://www.spice-space.org/download/windows/usbdk/$USBDK_MSI_X86 -O $TOOLS_USBDK_DIR/$USBDK_MSI_X86
fi

USBDK_PRODUCT_CODE_X64="{$(strings $TOOLS_USBDK_DIR/$USBDK_MSI_X64 | grep ProductCode | sed 's/.*ProductCode{//g' | sed 's/}.*//g')}"
USBDK_PRODUCT_CODE_X86="{$(strings $TOOLS_USBDK_DIR/$USBDK_MSI_X86 | grep ProductCode | sed 's/.*ProductCode{//g' | sed 's/}.*//g')}"

sed -i "s/#define[ ]*UsbdkVersion[ ]*\".*\"/#define UsbdkVersion \"${USBDK_VERSION}\"/" inno.iss
sed -i "s/#define[ ]*UsbdkAppIdx64[ ]*\".*\"/#define UsbdkAppIdx64 \"${USBDK_PRODUCT_CODE_X64}\"/" inno.iss
sed -i "s/#define[ ]*UsbdkAppIdx86[ ]*\".*\"/#define UsbdkAppIdx86 \"${USBDK_PRODUCT_CODE_X86}\"/" inno.iss

#
# cp210x driver
#

CP210X_ZIP="CP210x_VCP_Windows.zip"

CP210X_PRODUCT_CODE="3C57DA61F41601ACF85CC77F740AA00672E0BCD7"
sed -i "s/#define[ ]*SilabsCP210xAppId[ ]*\".*\"/#define SilabsCP210xAppId \"${CP210X_PRODUCT_CODE}\"/" inno.iss

if ! test -f $TOOLS_DIR/$CP210X_ZIP
then
  cd tools
  wget http://gimx.fr/download/CP210x_VCP_Windows -O $CP210X_ZIP
  mkdir -p CP210x_VCP_Windows
  cd CP210x_VCP_Windows
  unzip ../CP210x_VCP_Windows.zip
  cd ../..
fi

TOOLS_DRIVERS_DIR="$TOOLS_DIR/drivers"

ARDUINO_DRIVER_INF="https://raw.githubusercontent.com/arduino/Arduino/master/build/windows/dist/drivers/arduino.inf"
ARDUINO_DRIVER_CAT="https://raw.githubusercontent.com/arduino/Arduino/master/build/windows/dist/drivers/arduino.cat"

if ! test -f ${TOOLS_DRIVERS_DIR}/arduino.inf || ! test -f ${TOOLS_DRIVERS_DIR}/arduino.cat
then
  mkdir -p ${TOOLS_DRIVERS_DIR}
  pushd ${TOOLS_DRIVERS_DIR}
  wget ${ARDUINO_DRIVER_INF} -O arduino.inf
  wget ${ARDUINO_DRIVER_CAT} -O arduino.cat
  popd
fi

INNO_OPTIONS=""

if [ "$MSYSTEM" == "MINGW64" ]
then
  export MSYS2_ARG_CONV_EXCL="/dW64"
  INNO_OPTIONS+="/dW64"
fi

if test -f /c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe
then
  /c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe $INNO_OPTIONS inno.iss
else
  /c/Program\ Files/Inno\ Setup\ 5/ISCC.exe $INNO_OPTIONS inno.iss
fi

if [ "$MSYSTEM" == "MINGW32" ]
then
  mv gimx-$NEW_VERSION.exe gimx-$NEW_VERSION-i386.exe
else
  mv gimx-$NEW_VERSION.exe gimx-$NEW_VERSION-x86_64.exe
fi
