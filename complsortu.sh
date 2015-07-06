#!/bin/sh

firstrow=true

while read c r
do
	[ "$firstrow" == "true" ] && { echo $c $r ; nextr=$(expr "$r" + 1) ; firstrow=false ; continue ; }
	while [ "$nextr" -lt "$r" ] 
	do
		echo 0 "$nextr" ; nextr=$(expr "$nextr" + 1)
	done
	echo $c $r ; nextr=$(expr "$r" + 1)
done \
| awk '{c[NR]=$1;r[NR]=$2;lentmp=length($2);if(len<lentmp)len=lentmp} \
END{for(i=1;i<=NR;i++)printf "%s %"len".0f\n",c[i],r[i]}'
