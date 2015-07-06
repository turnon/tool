#!/bin/sh

wp=$(pwd)

until [ $wp = '/' ]
do
ls -dl $wp
wp=$(dirname $wp)
done | awk '{printf "%s %3s %5s %5s %5s %4s %3s %6s  %s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9 }'
