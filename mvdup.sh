#!/bin/sh

to_mv=$1
to_compare=$2
to_store=$3

ls *.$to_mv | while read b
do
  name=`echo $b | sed "s/\.$to_mv//"`
  ls "$name.$to_compare" && mv "$name.$to_mv" $to_store/
done
