#!/bin/sh

ROOT='alpine'
REPO='http://dl-cdn.alpinelinux.org/alpine/edge/main'
DM='curl -Sq --progress-bar -O'

export LANG='C'

if [ x$TRAVIS = xtrue ]
then
  FOLD_START="travis_fold:start:fold"
  FOLD_END="\ntravis_fold:end:fold\r"
fi

rm -rf $ROOT
mkdir -p $ROOT
if [ -d $ROOT-repo ]
then
  cp $ROOT-repo/x86_64/APKINDEX.tar.gz .
else
  $DM $REPO/x86_64/APKINDEX.tar.gz && printf '\r\033[1A\033[K'
fi
tar xf APKINDEX.tar.gz APKINDEX
APKVER=$(grep -A1 -e 'P:apk-tools-static' APKINDEX | sed -n 's/V:\(.*\)/\1/p')
if [ -d $ROOT-repo ]
then
  cp $ROOT-repo/x86_64/apk-tools-static-$APKVER.apk .
else
  $DM $REPO/x86_64/apk-tools-static-$APKVER.apk && printf '\r\033[1A\033[K'
fi
tar xf apk-tools-static-$APKVER.apk -C root sbin/apk.static 2>/dev/null
rm apk-tools-static-$APKVER.apk APKINDEX.tar.gz APKINDEX
cp -r root/* $ROOT

if [ -f x86_64-pc-linux-musl.tar.gz ]
then
  cp x86_64-pc-linux-musl.tar.gz $ROOT
fi

if [ -d src ]
then
  cp -R src $ROOT/nenuzhnix
fi

if [ -d $ROOT-repo ]
then
  cp -R $ROOT-repo $ROOT/repo
  REPO='/repo'
fi

$(which echo) -e "\n$FOLD_START\033[33;1minstalling base system\033[0m"
./proot -S $ROOT /sbin/apk.static --no-progress -X $REPO -U --no-cache --allow-untrusted --initdb add alpine-base
./proot -S $ROOT /bin/sh -c "echo $REPO > /etc/apk/repositories"
./proot -S $ROOT /sbin/apk --no-progress --no-cache add libstdc++ git curl wget make findutils tar coreutils bash automake autoconf libtool cmake ninja file patch bison libarchive-tools
$(which echo) -e "\n$FOLD_END"
if [ x$TRAVIS = xtrue ]
then
  echo 'export FOLD_START="travis_fold:start:fold"' >> $ROOT/etc/profile
  echo 'export FOLD_END="\ntravis_fold:end:fold\r"' >> $ROOT/etc/profile
fi
./proot -S $ROOT /usr/bin/env -i /bin/sh -l /install.sh
./proot -S $ROOT /usr/bin/env -i /bin/sh -l /build.sh
