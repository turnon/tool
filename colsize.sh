#!/bin/sh

awk '{for(i=1;i<=NF;i++) if(i==NF){printf "%.0f\n",length($i)}else{printf "%.0f ",length($i)}}' \
| awk '{if(NF>mnf){mnf=NF};for(i=1;i<=NF;i++) if($i>a[i]){a[i]=$i}} \
END{for(k=1;k<=mnf;k++) if(k==mnf){printf "%.0f\n",a[k]}else{printf "%.0f ",a[k]}}'
