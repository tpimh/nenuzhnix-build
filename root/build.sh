#!/bin/sh

export PATH=$PATH:/x86_64-pc-linux-musl/bin:/nenuzhnix-tools
export LD_LIBRARY_PATH=/x86_64-pc-linux-musl/lib

cd /nenuzhnix
./download-src.sh

while read PKG; do
  cd /nenuzhnix/$PKG
  opkg-buildpackage
done < /order.txt

echo done
