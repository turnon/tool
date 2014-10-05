#!/bin/sh

toscan=$([ -z "$1" ] && echo "." || echo "$1")

sp=$([ -z "$2" ] && echo 0 || echo "$2")

for f in "$toscan"/*
do
[ -e "$f" ] || continue
fdir=${f##*/}$([ -d "$f" ] && echo '/')
printf '%'"$sp"'s %-s\n' "" "$fdir"
[ -d "$f" ] && $0 "$f" $(expr "$sp" + 2)
done
