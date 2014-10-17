#!/bin/sh

. cleanicon.fn

cd $1

for f in $(ls bookm* 2>/dev/null)
do
newname=$(echo $f | sed 's/bookmarks_//' | tr '_'  '-')
orgdate=$(echo $newname | cut -d. -f1)
cleanicon $f >$newname
touch $newname -m -d $orgdate
rm -v $f
done
