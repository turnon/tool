#!/bin/sh

. cleanicon.fn

cd $1

ls --full-time bookm* \
| awk '{print $6,$7,$9}' \
| while read d1 t2 name
do
datestr=$(echo $name | sed 's/bookmarks_//g' | sed 's/\.html//g' | tr '_' '-')
newname=$(date -d $datestr +%y%m%d)'.html'
cleanicon $name >$newname
touch $newname -m -d "$d1 $t2"
rm -v $name
done
