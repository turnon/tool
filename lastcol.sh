#!/bin/sh

awk -v c="${1:-1}" '{for(i=NF-c;i>0;i--){$i=""};sub(/^\s+/, "", $0);print $0}'
