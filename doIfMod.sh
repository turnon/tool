#!/bin/sh

trap "rm $$.dim; exit" INT

file=$1
shift
echo $@ > $$.dim

lastMod(){
  ls -l --full-time "$file" | awk '{print $6,$7,$8}'
}

init=$(lastMod)

while true
do
  last=$(lastMod)
  if [ "$init" != "$last" ]
  then
    init=$last
    sh $$.dim
  fi
  sleep 1
done
