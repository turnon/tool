#!/bin/sh

# x=$2, y=$1

. storeflow.fn

store histgdata.$$ >/dev/null

{
lentmp=0
len=0
rows=0

while read y x
do
ylentmp=$(echo $y | wc -c)
xlentmp=$(echo $x | wc -c)
[ "$ylentmp" -gt "$xlentmp" ] && lentmp="$ylentmp" || lentmp="$xlentmp"
[ "$lentmp" -gt "$len" ] && len="$lentmp"
[ "$y" -gt "$rows" ] && rows="$y"
done <histgdata.$$

while read y x
do
printf '%'"$len"'s' "$x"
done <histgdata.$$

echo

i=0

while [ "$i" -le "$rows" ]
do
while read y x
do
[ "$i" -eq "$y" ] && printf '%'"$len"'s' "$y" ||  { [ "$i" -lt "$y" ] && printf '%'"$len"'s' "." || printf '%'"$len"'s' "" ; }
done <histgdata.$$
echo
i=$(expr "$i" + 1)
done

echo

} | tacawk.sh


rm histgdata.$$
