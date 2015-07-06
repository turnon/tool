#!/bin/sh

s="$1"

cd "$s"/..

bsn=$(basename "$s")

if ( echo "$bsn" | egrep '^\s*$' )
then
bsn="$s"
fi

ls -lhR "$bsn" | tee "$bsn"/"$bsn".list.txt
