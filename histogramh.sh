#!/bin/sh

# x=$2, y=$1

awk '{x[NR]=$2;y[NR]=$1; \
xlentmp=length($2);if(xlen<xlentmp)xlen=xlentmp} \
END{for(i=1;i<=NR;i++){printf "%"xlen"s",x[i];for(k=1;k<=y[i];k++)printf "%s","-";printf "%s\n",y[i]}}'