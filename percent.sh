#!/bin/sh

awk '{data[NR]=$1;rec[NR]=$2;sum=sum+$1} END{for(i=1;i<=NR;i++){per=data[i]/sum*100;printf "%6.2f%s %d %s\n",per,"",data[i],rec[i]}}'
