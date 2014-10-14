#!/bin/sh

. storeflow.fn

addslash()
{
echo $1 | sed 's/./\\&/g'
}

rmfirstcol()
{
while read line
do
firstcol=$(echo "$line" | awk '{print $1}')
echo "$line" | sed 's/^'"$firstcol"'//'
done
}

col="$1"

store lstcl.$$ >/dev/null

while [ "$col" -gt 1 ]
do
cat lstcl.$$ | rmfirstcol >lstcltmp.$$
mv lstcltmp.$$ lstcl.$$
col=$(expr "$col" - 1)
done

while read noheadsp
do
echo $noheadsp
done <lstcl.$$

rm lstcl.$$
