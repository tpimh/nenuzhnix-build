#!/bin/sh

ROOT='alpine'
REPO='http://dl-cdn.alpinelinux.org/alpine/edge/main'
DM='curl -Sq --progress-bar -O'

export LANG='C'

rm -rf $ROOT
mkdir -p $ROOT
echo -e "travis_fold:start:download\033[33;1mdownloading alpine package manager\033[0m"
$DM $REPO/x86_64/APKINDEX.tar.gz
tar xf APKINDEX.tar.gz APKINDEX
APKVER=$(grep -A1 -e 'P:apk-tools-static' APKINDEX | sed -n 's/V:\(.*\)/\1/p')
$DM $REPO/x86_64/apk-tools-static-$APKVER.apk
tar xf apk-tools-static-$APKVER.apk -C root sbin/apk.static 2>/dev/null
rm apk-tools-static-$APKVER.apk APKINDEX.tar.gz APKINDEX
echo -e "\ntravis_fold:end:download\r"
cp -r root/* $ROOT

echo -e "travis_fold:start:download\033[33;1minstalling base system\033[0m"
./proot -S $ROOT /sbin/apk.static --no-progress -X $REPO -U --no-cache --allow-untrusted --initdb add alpine-base
./proot -S $ROOT /bin/sh -c "echo $REPO > /etc/apk/repositories"
./proot -S $ROOT /sbin/apk --no-progress --no-cache add libstdc++ git curl wget make findutils tar coreutils bash automake autoconf libtool cmake ninja file patch bison libarchive-tools
echo -e "\ntravis_fold:end:download\r"
./proot -S $ROOT /usr/bin/env -i /bin/sh -l /install.sh
./proot -S $ROOT /usr/bin/env -i /bin/sh -l /build.sh
