#!/bin/sh

row=$1
col=$2

rowcount=0
filecount=1

while read line
do
rowcount=$(expr "$rowcount" + 1)
if [ "$rowcount" -gt "$row" ]
then
echo '-,' >> filecol."$filecount" 
[ "$filecount" -eq "$col" ] && filecount=1 || filecount=$(expr "$filecount" + 1)
rowcount=1
fi
echo $line >> filecol."$filecount" 
done

finalrow=$(cat filecol.1 | wc -l)

i=1

catline=''

while [ "$i" -le "$finalrow" ]
do
for f in filecol.*
do
catline="$catline"$(sed -n "$i"'p' $f)
done
echo $catline
catline=''
i=$(expr "$i" + 1)
done

rm filecol.*
