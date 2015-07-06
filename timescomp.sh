#!/bin/sh

run()
{
k=1

while [ "$times" -ge "$k" ]
do
printf "\n# %d %s\n\n" "$k" "$1"
time "$1"
k=$(expr "$k" + 1 )
done
}

analysis()
{
grep '^real' "$1" \
| cut -f2  | sed 's/[ms]/ /g' \
| cat -n \
| sort -k2n,2 -k3n,3 \
| cat -n \
| awk 'BEGIN {print;printf "%3s  %3s\n","sor","seq"} \
 {printf "%3s  %3s  %2d m %6.3f s\n",$1,$2,$3,$4} \
 {sum_mi=sum_mi+$3;sum_se=sum_se+$4} \
  END {sum_mi=sum_mi/NR;sum_se=sum_se/NR;printf "\naverage : %2d m %6.3f s\n",sum_mi,sum_se}'
}

while getopts a:r: op
do
case $op in
r) times=$OPTARG;;
a) subfix=$OPTARG;;
esac
done

if [ -z "$times" ]
then
analysis tmp1."$subfix"
analysis tmp2."$subfix"
rm cmd1."$subfix" tmp1."$subfix" cmd2."$subfix" tmp2."$subfix"
else
read cmd1
read cmd2
echo $cmd1 >cmd1.$$
echo $cmd2 >cmd2.$$
run cmd1.$$ 2>>tmp1.$$ &
run cmd2.$$ 2>>tmp2.$$ &
while true
do
sleep 10
jobs
done
fi
