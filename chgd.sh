#!/bin/sh

checkerr(){
	if [ $? -ne 0 ]; then
		exit 1
	fi
}

cd $1

fl=$(ls bookm*)

checkerr

for f in $fl
do
	orgdate=$(echo $f | cut -d_ -f2 | cut -d. -f1)
	touch $f -m -d $orgdate
done

fl=$(ls -rt bookm*)

for f in $fl
do
	orgdate=$(echo $f | cut -d_ -f2 | cut -d. -f1)
	mv -v $f bm.html
	checkerr
	git add bm.html
	git commit -m $orgdate
	echo
done

