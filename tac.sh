#!/bin/sh

pos=0

while read line
do
stack[$pos]="$line"
pos=$(expr $pos + 1)
done

while [ $pos -gt 0 ]
do
pos=$(expr $pos - 1)
echo "${stack[$pos]}"
done
