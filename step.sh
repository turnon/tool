#!/bin/sh

while getopts :b:e:s: op
do
case $op in
b) begin=$OPTARG;;
e) end=$OPTARG;;
s) step=$OPTARG;;
\?) echo 'wrong opt'
esac
done

{ [ -z "$begin" ] || [ -z "$end" ] || [ -z "$step" ] ; } && echo 'lack of opt' && exit

[ "$step" -eq 0 ] && echo 'zero step' && exit

[ "$step" -gt 0 ] && [ "$begin" -gt "$end" ] && echo 'exceed' && exit
[ "$step" -lt 0 ] && [ "$begin" -lt "$end" ] && echo 'exceed nega' && exit

[ "$begin" -lt "$end" ] && while [ "$begin" -le "$end" ]
do
echo "$begin"
begin=$(expr "$begin" + "$step")
done

[ "$begin" -gt "$end" ] && while [ "$begin" -ge "$end" ]
do
echo "$begin"
begin=$(expr "$begin" + "$step")
done
