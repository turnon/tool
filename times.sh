#!/bin/sh

read cmd1 cmd2

expr "$cmd1" + 1 >/dev/null 2>&1 \
&& { times=$cmd1 ; cmd=$cmd2 ; } \
|| { times=10 ; cmd="$cmd1 $cmd2" ; }

run()
{
while [ "$times" -ne 0 ]
do
times=$( expr "$times" - 1 )
time $cmd
done
}

{ run ; } 2>>tmp.$$

grep '^real' tmp.$$ \
| sed 's/real//' | sed 's/[ms]/ /g' \
| cat -n \
| sort -k2n,2 -k3n,3 \
| cat -n

rm tmp.$$
