#!/bin/sh

. storeflow.fn

store

m=1

while [ "$m" -le "$fieldnum" ]
do
flow \
| awk -v n=$m '{print $n}' | xargs
m=$(expr "$m" + 1 )
done
