#!/bin/sh

rm -rf nenuzhnix
mkdir nenuzhnix
cp opkg nenuzhnix
echo 'src/gz nenuzhnix http://golovin.in/nenuzhnix' > nenuzhnix/opkg.conf
./proot -S nenuzhnix /opkg --conf /opkg.conf update
./proot -S nenuzhnix /opkg --conf /opkg.conf install base-files curl dash libarchive libedit libressl libssh2 miniz musl netbsd-curses opkg toybox
rm nenuzhnix/opkg nenuzhnix/opkg.conf
echo nenuzhnix installed
./proot -S nenuzhnix /bin/esh -l
