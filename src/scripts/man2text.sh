#!/bin/sh

source=$1

if [ ! -e "$source" ]; then
  echo "Must supply source directory."
  exit 1;
fi

files=`find $source -name \*.1`;

for f in $files; do 
  echo $f
  groff -Tascii -mandoc -c -P -b -P -u -P -o $f > $f.txt 2> $f.err
done

