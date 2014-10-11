#!/bin/sh

awk '{for(i=1;i<=NF;i++) if(i==NF){printf "%.0f\n",length($i)}else{printf "%.0f ",length($i)}}' \
| awk '{if(NF>mnf){mnf=NF};for(i=1;i<=NF;i++) if($i>a[i]){a[i]=$i}} \
END{for(k=1;k<=mnf;k++) if(k==mnf){printf "%.0f\n",a[k]}else{printf "%.0f ",a[k]}}'

exit

cols="$1"

genpara()
{
cols="$1"

i=1

while [ "$i" -le "$cols" ]
do
param=f"$i"
export "$param"="$i"
echo "$param"
i=$(expr "$i" + 1)
done | xargs
}

paramlist=$(genpara "$cols")

echo "$paramlist"

for i in $paramlist
do
param="$i"
echo "$param"
done

#while read 
