#!/bin/bash

#don't forget to add universe to ~/.pbuilderrc

#uncomment in a new build environment
#sudo apt-get install gdebi devscripts pbuilder debhelper curl build-essential

PACKAGE="gimx"
OS=$1
DIST=$2
ARCH=$3
DATE=`date -R`
YEAR=`date +"%Y"`
BRANCH="master"

usage() {
  echo "usage: ./build <ubuntu, debian, raspbian> <xenial, jessie, stretch> <amd64, i386, armhf>"
}

echo "OS: "${OS}

if [ -z ${OS} ]
then
  echo No OS specified.
  usage
  exit
fi

echo "Distribution: "${DIST}

if [ -z ${DIST} ]
then
  echo No distribution specified.
  usage
  exit
fi

echo "Architecture: "${ARCH}

if [ -z ${ARCH} ]
then
  echo No architecture specified.
  usage
  exit
fi

rm -rf $PACKAGE*

git clone -b $BRANCH --single-branch --depth 1 --recursive https://github.com/matlo/GIMX.git

VERSION=$(grep "#define INFO_VERSION " GIMX/info.h)
VERSION=${VERSION#*\"}
VERSION=${VERSION%%\"*}

mv GIMX $PACKAGE-${VERSION}

cp -r debian $PACKAGE-${VERSION}

cd $PACKAGE-${VERSION}

FIXED=`curl -s -L "https://github.com/matlo/GIMX/issues?labels=GIMX+${VERSION}&state=closed" | grep "        #[0-9][0-9]*" | sed 's/        //g' | sed ':a;N;$!ba;s/\n/ /g'`

echo Fixed: $FIXED
echo Date: $DATE
echo Year: $YEAR

sed -i "s/#VERSION#/${VERSION}/" debian/changelog
sed -i "s/#FIXED#/$FIXED/" debian/changelog
sed -i "s/#DATE#/$DATE/" debian/changelog

sed -i "s/#DATE#/$DATE/" debian/copyright
sed -i "s/#YEAR#/$YEAR/" debian/copyright

if [ "${DIST}" == "jessie" ]
then
  sed -i "s/libwxgtk3.0-0v5/libwxgtk3.0-0/" debian/control
fi

OS=${OS} DIST=${DIST} ARCH=${ARCH} pdebuild

cd ..

cp /var/cache/pbuilder/${OS}-${DIST}-${ARCH}/result/$PACKAGE\_${VERSION}-1_*.deb .
