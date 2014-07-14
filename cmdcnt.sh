#!/bin/sh

checkcmd(){
( [ $1 == "|" ] || [ $1 == ";" ] || type $1 1>/dev/null 2>&1 ) && echo $1
}

for word in $(cat $1)
do
checkcmd $word >>cmdtmp.$$
done

sort cmdtmp.$$ | uniq -c | sort -r

rm -f cmdtmp.$$
