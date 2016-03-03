#!/bin/sh

while [ "$#" -gt 0 ]
do
  if [ -f $1 ]
  then
    echo ${1##*.}
  else
    find $1 -type f | while read p
    do
      f=$(basename $p)
      echo ${f##*.}
    done
  fi
  shift
done | sort | uniq