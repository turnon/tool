#!/bin/sh

onearg()
{
printf "%.f" "$1" >/dev/null 2>&1 || { echo ${#1} 's' ; exit ; }

echo "$1" | awk -F'.' '{if(NF>=2){print length($1)+length($2)+1"."length($2),"f"}else{print length($1),"d"}}'
}

colarg()
{
while read firstcol othcol
do
onearg $firstcol
done \
| sort -k2,2 -nk1,1 \
| tail -n1
}

[ -z "$1" ] && colarg || onearg "$1"
