#!/bin/sh

# show diff with non-compressed bookmark

ls $1/*.html \
| prevcurr.sh \
| while read pre
do
read nex
diff $pre $nex | grep 'HREF' >difdetail.$$
rsub=$(grep -c '^<' difdetail.$$ )
radd=$(grep -c '^>' difdetail.$$ )
echo ${nex##*/} $rsub $radd
done

rm -f difdetail.$$
