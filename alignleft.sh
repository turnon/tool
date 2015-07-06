#!/bin/sh

aleft()
{
while read line
do
echo $line
done
}

[ -f "$1" ] && cat "$1" | aleft || aleft
