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
sh cmd.$$ &
done
}

del()
{
sleep 5
rm cmd.$$
}

run

del &
