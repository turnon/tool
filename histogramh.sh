#!/bin/sh

# x=$2, y=$1

awk '{x[NR]=$2;y[NR]=$1; \
xlentmp=length($2);if(xlen<xlentmp)xlen=xlentmp} \
END{for(i=1;i<=NR;i++){printf "%"xlen"s %"y[i]"s\n",x[i],y[i]}}'
