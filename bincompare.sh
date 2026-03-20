#!/bin/bash

# Compare 2x binary files

if [ $# -lt 2 ]
then
  echo "Specify two files to compare"
  exit 0
fi

bina="$1"
binb="$2"

hexdump -v -C ${bina} > ${bina}.bincomp
hexdump -v -C ${binb} > ${binb}.bincomp

meld ${bina}.bincomp ${binb}.bincomp 2>&1
rm ${bina}.bincomp ${binb}.bincomp >/dev/null 2>&1
