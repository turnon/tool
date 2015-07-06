#!/bin/sh

aright()
{
awk '{lin[NR]=$0; lentmp=length($0); if(len<lentmp)len=lentmp} \
END{for(i=1;i<=NR;i++) printf "%"len"s\n",lin[i]}'
}

[ -f "$1" ] && { ./alignleft.sh "$1" | aright ; } || { ./alignleft.sh | aright ; }
