#!/bin/bash

PACKAGE="gimx"
OS=$1
DIST=$2
ARCH=$3
DATE=`date -R`
YEAR=`date +"%Y"`
BRANCH="master"

usage() {
  echo "usage: ./build <ubuntu, debian, raspbian> <focal, buster> <amd64, armhf>"
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

BUILDRESULT=/var/cache/pbuilder/${OS}-${DIST}-${ARCH}/result
APTCACHE=/var/cache/pbuilder/${OS}-${DIST}-${ARCH}/aptcache

if ! test -f /var/cache/pbuilder/${OS}-${DIST}-${ARCH}-base.tgz
then
  sudo apt-get install gdebi devscripts pbuilder debhelper curl build-essential
  sudo mkdir -p ${APTCACHE}
  sudo OS=${OS} DIST=${DIST} ARCH=${ARCH} pbuilder create --configfile ./pbuilderrc
  if [ $? -ne 0 ]
  then
    sudo rm -rf /var/cache/pbuilder/${OS}-${DIST}-${ARCH}*
    exit
  fi
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

OS=${OS} DIST=${DIST} ARCH=${ARCH} pdebuild --configfile ../pbuilderrc

cd ..

cp ${BUILDRESULT}/$PACKAGE\_${VERSION}-1_${ARCH}.deb $PACKAGE\_${VERSION}-1_${OS}-${DIST}-${ARCH}.deb
