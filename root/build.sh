#!/bin/sh

export PATH=$PATH:/x86_64-pc-linux-musl/bin:/nenuzhnix-tools
export LD_LIBRARY_PATH=/x86_64-pc-linux-musl/lib

SUCCESS=0
FAIL=0

cd /nenuzhnix
./download-src.sh

while read PKG; do
  cd /nenuzhnix/$PKG
  opkg-buildpackage && SUCCESS=$((SUCCESS+1)) || FAIL=$((FAIL+1))
done < /order.txt

echo $SUCCESS packages built, $FAIL packages failed
