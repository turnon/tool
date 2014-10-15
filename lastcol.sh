#!/bin/sh

. storeflow.fn

col="$1"

rmfstcol()
{
awk '{sub($1,"");print $0}' "$1"
}

# main
store lstcl.$$ >/dev/null

while [ "$col" -gt 1 ]
do
rmfstcol lstcl.$$ >lstcltmp.$$
mv lstcltmp.$$ lstcl.$$
col=$(expr "$col" - 1)
done

alignleft.sh lstcl.$$

rm lstcl.$$
