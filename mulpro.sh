#!/bin/sh

expr "$1" + 1 >/dev/null 2>&1 && times=$1 || times=1

read cmd

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
