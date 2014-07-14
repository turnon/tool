#!/bin/sh

checkcmd(){
( [ $1 == "|" ] || [ $1 == ";" ] || type $1 1>/dev/null 2>&1 ) && echo $1
}

getcmd(){
for word in $(cat $1)
do
checkcmd $word
done
}

getcmd $1 | sort | uniq -c | sort -nr
