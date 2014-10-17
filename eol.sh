#!/bin/sh

eol="$1"

#while getopts i:d: op
#do
#case $op in
#i) interval=$(expr "$interval" \* $OPTARG );;
#d) interval=$(expr "$interval" / $OPTARG );;
#esac
#done

# set interval
# each charater
# wait
# EOL

awk -v eol=$eol \
'{k=1;for(i=1;i<=length($0);i++){if (k>eol){k=1;printf "\n",""};printf "%s",substr($0,i,1);k++};printf "\n",""}'
