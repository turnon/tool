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
| sed 's/m/ & /' | sed 's/s/ & /' \
| sort -k2n,2 -k4n,4

rm tmp.$$
