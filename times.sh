#!/bin/sh

read cmd

run()
{
for i in {1..10}
do
time $cmd
done
}

{ run ; } 2>>tmp.$$

grep '^real' tmp.$$ \
| sed 's/real//' | sed 's/[ms]/ /g' \
| cat -n \
| sort -k2n,2 -k3n,3 \
| cat -n

rm tmp.$$
