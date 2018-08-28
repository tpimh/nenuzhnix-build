#!/bin/sh

NENREPO='https://github.com/tpimh/nenuzhnix.git'
NGTC='https://golovin.in/x86_64-pc-linux-musl.tar.gz'

cd /
echo -e "travis_fold:start:download\033[33;1mcloning nenuzhnix\033[0m"
git clone $NENREPO
echo -e "\ntravis_fold:end:download\r"
echo -e "travis_fold:start:download\033[33;1mobtaining ngtc\033[0m"
curl --progress-bar -O $NGTC
tar xfz x86_64-pc-linux-musl.tar.gz 
echo -e "\ntravis_fold:end:download\r"
echo -e "travis_fold:start:download\033[33;1mdownloading sources\033[0m"
cd /nenuzhnix
./download-src.sh
echo -e "\ntravis_fold:end:download\r"
