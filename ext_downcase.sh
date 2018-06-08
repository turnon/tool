#!/bin/sh

ls | sed 's/.*\.\(.*\)/\1/g' | sort -u | while read ext;do ext_d=`echo $ext | tr 'A-Z' 'a-z'`;ext_rename.sh "$ext" "$ext_d";done
