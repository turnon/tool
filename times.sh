#!/bin/sh

read cmd1 cmd2

expr "$cmd1" + 1 >/dev/null 2>&1 \
&& { times=$cmd1 ; cmd=$cmd2 ; } \
|| { times=10 ; cmd="$cmd1 $cmd2" ; }

echo $cmd >cmd.$$

run()
{
while [ "$times" -ne 0 ]
do
times=$( expr "$times" - 1 )
time cmd.$$
done
}

{ run ; } 2>>tmp.$$

grep '^real' tmp.$$ \
| cut -f2  | sed 's/[ms]/ /g' \
| cat -n \
| sort -k2n,2 -k3n,3 \
| cat -n \
| awk 'BEGIN {print;printf "%3s  %3s\n","sor","seq"} \
 {printf "%3s  %3s  %2d m %6.3f s\n",$1,$2,$3,$4} \
 {sum_mi=sum_mi+$3;sum_se=sum_se+$4} \
  END {sum_mi=sum_mi/NR;sum_se=sum_se/NR;printf "\naverage : %2d m %6.3f s\n",sum_mi,sum_se}'

rm cmd.$$ tmp.$$
