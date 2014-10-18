#!/bin/sh

col="$1"

rmfstcol()
{
awk '{sub($1,"");print $0}' "$1"
}

# main
awk '{print $0}' > lstcl.$$

while [ "$col" -gt 1 ]
do
rmfstcol lstcl.$$ >lstcltmp.$$
mv lstcltmp.$$ lstcl.$$
col=$(expr "$col" - 1)
done

alignleft.sh lstcl.$$

rm lstcl.$$
