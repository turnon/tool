#!/bin/sh

dire=$([ -z "$1" ] && echo "." || echo "$1")

for f in "$dire"/*/
do
[ -e "$f" ] || continue
fdir=$(basename "$f")
fcount=$(ls "$f" | wc -l )
printf "%3d   %-80s\n" "$fcount" "$fdir"
done
