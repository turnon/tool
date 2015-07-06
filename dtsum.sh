#!/bin/sh

fda()
{
awk \
'BEGIN {d=0;a=0} \
'/H3/'{d=d+1} '/HREF/'{a=a+1} \
END {printf "%-13s %3d %5d\n",FILENAME,d,a}' \
$1
}

if [ $# -gt 0 ]
then
fda $1
else
while read f
do
fda $f
done
fi
