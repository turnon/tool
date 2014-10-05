#!/bin/sh

# replace semicolon
rcl()
{
[ "$1" = ';' ] && echo 0 || echo ${1%\;}
}

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
a=$(rcl "$a")
b=$(dat $(rcl "$b"))
c=$(rcl "$c")
d=$(rcl "$d")
e=$(rcl "$e")
f=$(rcl "$f")
g=$(rcl "$g")
printf '%16s %6s %8s %9.2f %9.2f %9.2f %-50s\n' "$a" "$b" "$c" "$d" "$e" "$f" "$g"
done
}

grep -h '\;$' "$1"* \
| fmt \
| sort -u 
