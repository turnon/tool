#!/bin/sh

. cleanicon.fn

cd $1

for f in $(ls bookm* 2>/dev/null)
do
newname=$(echo $f | cut -d_ -f2)
orgdate=$(echo $f | cut -d_ -f2 | cut -d. -f1)
cleanicon $f >$newname
touch $newname -m -d $orgdate
rm -v $f
done
