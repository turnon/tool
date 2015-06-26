#!/bin/sh

while read d 
do
echo "$d"
cd  "$d"
git fetch origin master:master_tmp
git merge master_tmp
printf '\n%s\n\n' '----------'
done
