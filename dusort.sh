#!/bin/sh

encode()
{
echo $1 | tr 'BKMG' '1234'
}

decode()
{
echo $1 | tr '1234' 'BKMG' 
}

humansize()
{
while read SIZE NAME
do
NEW_SIZE=$(encode "$(echo "$SIZE" | sed 's/[A-Z]/ &/' | sed 's/[0-9]$/& B/' )")
NEW_NAME=$(basename "$NAME")$([ -d "$NAME" ] && echo '/' )
echo $NEW_SIZE $NEW_NAME
done
}

sortbysize()
{
sort -k2n,2 -k1n,1
}

format()
{
while read SIZE1 SIZE2 NAME
do
NEW_SIZE2=$(decode "$SIZE2")
printf '%6.1f %1s  %-20s\n' $SIZE1 $NEW_SIZE2 "$NAME"
done
}

## main
du "$([ -z "$1" ] && echo '.' || echo "$1")"/* -h --max-depth=0 | humansize | sortbysize | format
