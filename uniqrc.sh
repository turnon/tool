#!/bin/sh

# uniq --range -c

# function to create range
range()
{
step.sh "$@" | sed '$d' | xargs
step.sh "$@" | sed -n '2,$p' | xargs
}

# create range and store it in tmp file
range "$@" | coltorow.sh | cat -n > uniqrc.$$

# initial array
while read row min max
do
arr[$row]=0
done < uniqrc.$$

# count
while read record
do
while read row min max
do
[ "$record" -ge "$min" ] && [ "$record" -lt "$max" ] && arr[$row]=$(expr ${arr[$row]} + 1)
done < uniqrc.$$
done

# print result
while read row min max
do
echo ${arr[$row]} $min '-' $max
done < uniqrc.$$

# del tmp
rm uniqrc.$$
