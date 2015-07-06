#!/bin/sh

fmdir=$1
todir=$2

. cleanicon.fn

onlybm()
{
git log --oneline | grep '[0-9]$'
}

cd $fmdir

while read commitid bmdate
do
git checkout $commitid
cleanicon bm.html >"$todir"/"$bmdate".html
done<<EOF
$(onlybm)
EOF

git checkout master
