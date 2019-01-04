#!/bin/sh

NENREPO='https://github.com/tpimh/nenuzhnix.git'
NGTC='https://golovin.in/x86_64-pc-linux-musl.tar.gz'

cd /
echo -e "$FOLD_START\033[33;1mcloning nenuzhnix\033[0m"
if [ ! -e nenuzhnix ]
then
  git clone $NENREPO
else
  echo using local copy of nenuzhnix
fi
echo -e "\n$FOLD_END"
echo -e "$FOLD_START\033[33;1mobtaining ngtc\033[0m"
if [ ! -e x86_64-pc-linux-musl.tar.gz ]
then
  curl --progress-bar -O $NGTC
else
  echo using local copy of ngtc
fi
tar xfz x86_64-pc-linux-musl.tar.gz 
echo -e "\n$FOLD_END"
echo -e "$FOLD_START\033[33;1mdownloading sources\033[0m"
cd /nenuzhnix
./download-src.sh
echo -e "\n$FOLD_END"
