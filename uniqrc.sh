#!/bin/sh

# uniq --range -c

range()
{
step.sh "$@" | sed '$d' | xargs
step.sh "$@" | sed -n '2,$p' | xargs
}

range "$@" | coltorow.sh | cat -n > uniqrc.$$

while read row min max
do
arr[$row]=0
done < uniqrc.$$

while read record
do
while read row min max
do
[ "$record" -ge "$min" ] && [ "$record" -lt "$max" ] && arr[$row]=$(expr ${arr[$row]} + 1)
done < uniqrc.$$
done

while read row min max
do
echo ${arr[$row]} $min '-' $max
done < uniqrc.$$

rm uniqrc.$$
