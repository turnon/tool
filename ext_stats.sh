#!/bin/sh

while [ "$#" -gt 0 ]
do
  if [ -f $1 ]
  then
    echo ${1##*.}
  else
    find $1 -type f -not -path '*/.git/*' -not -name '.*' -name '*.*' | while read p
    do
      f=$(basename "$p")
      echo ${f##*.}
    done
  fi
  shift
done | sort | uniq -c | sort -h
