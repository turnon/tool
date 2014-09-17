#!/bin/sh

if [ $# -ge 2 ]
then
from=$1
to=$2
elif [ $# -eq 1 ]
then
from=1
to=$1
else
exit
fi

while [ $from -le $to ]
do
echo $from
from=$(expr $from + 1)
done
