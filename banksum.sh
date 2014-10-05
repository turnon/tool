#!/bin/sh

# date format yyyymmdd
dat()
{
echo "${1:2:2}""${1:5:2}""${1:8:2}"
}

#format
fmt()
{
while read a b c d e f g
do
b=$(dat "$b")
printf '%16s %6s %8s %9.2f %9.2f %9.2f %-50s\n' "$a" "$b" "$c" "$d" "$e" "$f" "$g"
done
}

grep -h '\;$' "$1"* \
| awk -F';' '{printf "%s %s %s %f %f %f %s\n",$1,$2,$3,$4,$5,$6,$7}' \
| fmt \
| sort -u
