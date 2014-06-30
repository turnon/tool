#!/bin/sh

bmlog=$(git log --oneline --reverse | grep '[0-9]$'  | awk '{print $1}')

pre=$(echo $bmlog | cut -d' ' -f1)
other=$(echo $bmlog | cut -d' ' -f2- )

for nex in $other
do
git diff $pre $nex | grep 'HREF' > difdetail.$$
rsub=$(grep -c '^[-]' difdetail.$$ )
radd=$(grep -c '^[+]' difdetail.$$ )
echo $(date --date=$(git log $nex --oneline | head -n1 | awk '{print $2}' ) +%y%m%d ) $rsub $radd
pre=$nex
done

rm -f difdetail.$$