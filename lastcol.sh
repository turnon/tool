#!/bin/sh

col="$1"

awk -v c=$col '{for(i=c-1;i>0;i--){$i=""};print $0}' | alignleft.sh
