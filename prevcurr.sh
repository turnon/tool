#!/bin/sh

prev=''

while read curr
do
[ -z "$prev" ] && prev="$curr" && continue
printf "%s\n%s\n" "$prev" "$curr"
prev="$curr"
done
