#!/bin/sh

NENREPO='https://github.com/tpimh/nenuzhnix.git'
NGTC='http://golovin.in/x86_64-pc-linux-musl.tar.gz'

cd /
echo -e "travis_fold:start:c\033[33;1mcloning nenuzhnix\033[0m"
git clone $NENREPO
echo -e "\ntravis_fold:end:c\r"
echo -e "travis_fold:start:d\033[33;1mobtaining ngtc\033[0m"
curl --progress-bar -O $NGTC
tar xfz x86_64-pc-linux-musl.tar.gz 
echo -e "\ntravis_fold:end:d\r"
