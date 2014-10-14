#!/bin/sh

. storeflow.fn

read lines fields<<EOF
$(store strf.$$)
EOF

m=1

while [ "$m" -le "$fields" ]
do
awk -v n=$m '{printf "%s ",$n} END{printf "\n",""}' strf.$$
m=$(expr "$m" + 1 )
done

rm strf.$$
