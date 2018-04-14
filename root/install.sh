#!/bin/sh

NENREPO='https://github.com/tpimh/nenuzhnix.git'
NGTC='http://golovin.in/x86_64-pc-linux-musl.tar.gz'

git clone $NENREPO
echo obtaining ngtc
curl --progress-bar -O $NGTC
tar xfz x86_64-pc-linux-musl.tar.gz 
