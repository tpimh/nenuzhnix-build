#!/bin/sh

rm /bin/mv
ln -s /bin/busybox /bin/mv

export PATH=$PATH:/x86_64-pc-linux-musl/bin:/nenuzhnix-tools
export LD_LIBRARY_PATH=/x86_64-pc-linux-musl/lib
export PKG_CONFIG_SYSROOT_DIR=/x86_64-pc-linux-musl
export PKG_CONFIG_LIBDIR=/x86_64-pc-linux-musl/lib/pkgconfig

install_opk() {
  cd /x86_64-pc-linux-musl
  ar p /nenuzhnix/$1_*.opk data.tar.gz | tar xfz -
}

SUCCESS=0
FAIL=0

cd /nenuzhnix
./download-src.sh

while read PKG; do
  cd /nenuzhnix/$PKG
  opkg-buildpackage > /dev/null && SUCCESS=$((SUCCESS+1)) || FAIL=$((FAIL+1))
  install_opk $PKG
done < /order.txt

echo $SUCCESS packages built, $FAIL packages failed
