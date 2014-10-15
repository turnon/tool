#!/bin/sh

# x=$2, y=$1

[ -z "$1" ] && reduce=1 || reduce="$1"

awk -v rd=$reduce '{x[NR]=$2;y[NR]=$1; \
xlentmp=length($2);if(xlen<xlentmp)xlen=xlentmp} \
END{for(i=1;i<=NR;i++){printf "%"xlen"s : ",x[i];for(k=1;k<=int(y[i]/rd);k++)printf "%s","/";printf "%s\n",y[i]}}'
