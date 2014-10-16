#!/bin/sh

# x=$2, y=$1

[ -z "$1" ] && reduce=1 || reduce="$1"

alignleft.sh \
| awk -v rd=$reduce '{y[NR]=$1;sub($1,"");x[NR]=$0; \
xlentmp=length($0);if(xlen<xlentmp)xlen=xlentmp} \
END{for(i=1;i<=NR;i++){printf "%"xlen"s : ",x[i];for(k=1;k<=int(y[i]/rd);k++)printf "%s","/";printf "%s\n",y[i]}}'
