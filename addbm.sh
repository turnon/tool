#!/bin/sh

. cleanicon.fn

cd $1

ls --full-time bookm* \
| awk '{print $7,$8,$9,$10,$11}' \
| while read d1 d2 d3 d4 name
do
newname="$(echo $name | sed 's/[^0-9]/ /g' | awk '{printf "%2.0f%2.0f%2.0f\n",$1,$2,$3}')"'.html'
cleanicon $name >$newname
touch $newname -m -d "$d1 $d2 $d3 $d4"
rm -v $name
done
