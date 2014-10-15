#!/bin/sh

# x=$2, y=$1

. storeflow.fn

store histgdata.$$ >/dev/null

[ -z "$1" ] && reduce=1 || reduce="$1"

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

rows=$(expr "$rows" / "$reduce")

while [ "$i" -le "$rows" ]
do
while read y x
do
rdy=$(expr "$y" / "$reduce")
[ "$i" -eq "$rdy" ] && printf '%'"$len"'s' "$y" ||  { [ "$i" -lt "$rdy" ] && printf '%'"$len"'s' "." || printf '%'"$len"'s' "" ; }
done <histgdata.$$
echo
i=$(expr "$i" + 1)
done

echo

} | tacawk.sh


rm histgdata.$$
