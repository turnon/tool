#!/bin/sh

interval=250000

while getopts i:d: op
do
case $op in
i) interval=$(expr "$interval" \* $OPTARG );;
d) interval=$(expr "$interval" / $OPTARG );;
esac
done

# set interval
# each charater
# wait
# EOL

awk -v intv=$interval \
'{for(i=1;i<=length($0);i++){printf "%s",substr($0,i,1); \
for(slp=1;slp<=intv;slp++){}}; \
printf "\n",""}'
