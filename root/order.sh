#!/bin/sh

ORDERED="base-files musl kernel-headers"

PACKAGES=$(find . -maxdepth 2 -mindepth 2 -name 'opkg' -type d | sed 's/\.\/\(.*\)\/opkg/\1/')

getfield() {
  grep -e "^$2: " $1/opkg/control | sed 's/^'$2': \(.*\)$/\1/'
}

provides() {
  if [ "$1" = "$2" ]; then
    exit 0
  fi

  if [ "$2" = "$(getfield $1 Provides)" ]; then
    exit 0
  fi

  exit 1
}

depends() {
  echo $(getfield $1 Depends | tr -d ,)
}

inarr() {
  for PACKAGE in $ORDERED; do
    if $(provides $PACKAGE $1); then
      exit 0
    fi
  done

  exit 1
}

allin() {
  for PACKAGE in "$@"; do
    if ! $(inarr $PACKAGE); then
      exit 1
    fi
  done

  exit 0
}

n() {
  echo $#
}

add() {
  ORDERED="$ORDERED $1"
}

while [ "$(n $ORDERED)" -ne "$(n $PACKAGES)" ]; do
  for PACKAGE in $PACKAGES; do
    if ! $(inarr $PACKAGE); then
      DEPENDS="$(depends $PACKAGE)"
      if $(allin $DEPENDS); then
        add $PACKAGE
      fi
    fi
  done
done

echo $ORDERED
