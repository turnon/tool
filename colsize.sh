#!/bin/sh

while read line
do
echo "$line" | awk '{for(i=1;i<=NF;i++)print length($i)}' | xargs
done

exit

cols="$1"

genpara()
{
cols="$1"

i=1

while [ "$i" -le "$cols" ]
do
param=f"$i"
export "$param"="$i"
echo "$param"
i=$(expr "$i" + 1)
done | xargs
}

paramlist=$(genpara "$cols")

echo "$paramlist"

for i in $paramlist
do
param="$i"
echo "$param"
done

#while read 
