#!/bin/sh

#format
fmt()
{
while read acc dat cur amt1 amt2 amt3 ds1 ds2 ds3 ds4 ds5 ds6
do
printf '%16s %6s %8s %9.2f %9.2f %9.2f %-50s\n' \
"$acc" "${dat:2:2}""${dat:5:2}""${dat:8:2}" "$cur" "$amt1" "$amt2" "$amt3" "$ds1 $ds2 $ds3 $ds4 $ds5 $ds6"
done
}

grep -h '\;$' "$1"* \
| awk -F';' '{printf "%s %s %s %f %f %f %s\n",$1,$2,$3,$4,$5,$6,$7}' \
| fmt \
| sort -u
