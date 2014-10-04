#!/bin/sh

awk 'BEGIN {b=0} {a=$3;c=a-b;print $1,$2,$3,c;b=a}'
