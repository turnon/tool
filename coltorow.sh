#!/bin/sh

. storeflow.fn

store strf.$$

m=1

while [ "$m" -le "$fieldnum" ]
do
awk -v n=$m '{printf "%s ",$n} END{printf "\n",""}' strf.$$
m=$(expr "$m" + 1 )
done

rm strf.$$
