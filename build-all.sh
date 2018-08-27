#!/bin/sh

ROOT='alpine'
REPO='http://dl-cdn.alpinelinux.org/alpine/edge/main'
APKVER='2.10.0-r3'

export LANG='C'

rm -rf $ROOT
mkdir -p $ROOT
echo -e "travis_fold:start:a\033[33;1mdownloading apk-tools\033[0m"
wget $REPO/x86_64/apk-tools-static-$APKVER.apk
tar xf apk-tools-static-$APKVER.apk -C root sbin/apk.static 2>/dev/null
rm apk-tools-static-$APKVER.apk
echo -e "\ntravis_fold:end:a\r"
cp -r root/* $ROOT

echo -e "travis_fold:start:b\033[33;1minstalling base system\033[0m"
./proot -S $ROOT /sbin/apk.static --no-progress -X $REPO -U --no-cache --allow-untrusted --initdb add alpine-base
./proot -S $ROOT /bin/sh -c "echo $REPO > /etc/apk/repositories"
./proot -S $ROOT /sbin/apk --no-progress --no-cache add libstdc++ git curl wget make findutils tar coreutils bash automake autoconf libtool cmake ninja file patch bison libarchive-tools
echo -e "\ntravis_fold:end:b\r"
./proot -S $ROOT /usr/bin/env -i /bin/sh -l /install.sh
./proot -S $ROOT /usr/bin/env -i /bin/sh -l /build.sh
