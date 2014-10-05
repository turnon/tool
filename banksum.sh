#!/bin/sh

#format
fmt()
{
while read a b c d e f g
do
printf '%16s %6s %8s %9.2f %9.2f %9.2f %-50s\n' "$a" "${b:2:2}""${b:5:2}""${b:8:2}" "$c" "$d" "$e" "$f" "$g"
done
}

grep -h '\;$' "$1"* \
| awk -F';' '{printf "%s %s %s %f %f %f %s\n",$1,$2,$3,$4,$5,$6,$7}' \
| fmt \
| sort -u
