#!/bin/sh

cur_b=$(git branch | grep '^*' | sed 's/^\**\s*//g')

git branch | sed 's/^\**\s*//g' | grep -v 'tmp$' | while read bch
do
git checkout $bch
git fetch origin $bch:${bch}_tmp
git merge ${bch}_tmp
done

git checkout $cur_b
