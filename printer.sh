#!/bin/sh

interval=250000

# set interval
# each charater
# wait
# EOL

awk -v intv=$interval \
'{for(i=1;i<=length($0);i++){printf "%s",substr($0,i,1); \
for(slp=1;slp<=intv;slp++){}}; \
printf "\n",""}'
