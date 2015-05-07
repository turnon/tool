#!/bin/sh

while read d 
do
echo "$d"
cd  "$d"
git fetch origin master:tmp
git merge tmp
printf '\n%s\n\n' '----------'
done
