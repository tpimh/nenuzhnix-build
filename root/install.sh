#!/bin/sh

NENREPO='https://github.com/tpimh/nenuzhnix.git'

cd /
echo -e "$FOLD_START\033[33;1mcloning nenuzhnix\033[0m"
if [ ! -e nenuzhnix ]
then
  git clone $NENREPO
else
  echo using local copy of nenuzhnix
fi

echo -n 'generating order: '
cd /nenuzhnix
ORDER="$(/order.sh)"
echo $ORDER
echo "$ORDER" | tr ' ' '\n' > /order.txt

echo -e "\n$FOLD_END"
echo -e "$FOLD_START\033[33;1mdownloading sources\033[0m"
/download-src.sh
echo -e "\n$FOLD_END"
