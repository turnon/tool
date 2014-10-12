#!/bin/sh

. storeflow.fn

store

lens=$(\
flow \
| awk '{for(i=1;i<=NF;i++) if(i==NF){printf "%.0f\n",length($i)}else{printf "%.0f ",length($i)}}' \
| awk '{if(NF>mnf){mnf=NF};for(i=1;i<=NF;i++) if($i>a[i]){a[i]=$i}} \
END{for(k=1;k<=mnf;k++) if(k==mnf){printf "%.0f\n",a[k]}else{printf "%.0f ",a[k]}}' \
)

cols=$(echo $lens | wc -w)

para=$(seq.sh "$cols" | xargs | sed 's/[0-9]*/\$&\,/g' | sed 's/\,$//')

types=$(
m=1
while [ $m -le "$cols" ]
do
{ flow \
| awk -v n=$m '{print $n}' \
| grep -E '[a-zA-Z:]' ; } >/dev/null && echo 's' || echo 'd'
m=$(expr "$m" + 1 )
done | xargs \
)

formatp=$( \
{ echo $lens;echo $types; } \
| coltorow.sh \
| awk '{if($2=="s"){printf "%-6s","%-"$1$2}else{printf "%-6s","%"$1$2}} END{printf "%1s","\n"}' \
)

formatp='"'$formatp'\n",'"$para"

flow \
| awk '{printf '"$formatp"'}'
