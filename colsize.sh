#!/bin/sh

awk '{print $0}' > colsiz.$$

cols=$(awk '{print NF}' colsiz.$$ | sort -n | tail -n1)

m=1

while [ "$m" -le "$cols" ]
do
awk -v n=$m '{print length($n)}' colsiz.$$ | sort -n | tail -n1
m=$(expr "$m" + 1 )
done \
| xargs

m=1

while [ "$m" -le "$cols" ]
do
awk -v n=$m '{print $n}' colsiz.$$ | grep '[a-zA-Z]' > /dev/null && echo s || echo f
m=$(expr "$m" + 1 )
done \
| xargs

rm colsiz.$$
