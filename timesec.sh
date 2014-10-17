#!/bin/sh

read cmd1 cmd2

expr "$cmd1" + 1 >/dev/null 2>&1 \
&& { times=$cmd1 ; cmd=$cmd2 ; } \
|| { times=10 ; cmd="$cmd1 $cmd2" ; }

echo $cmd >cmd.$$

run()
{
i=1

while [ "$times" -ge "$i" ]
do
printf "\n# %d\n\n" "$i"
beg=$(date +%s)
cmd.$$
end=$(date +%s)
secarr[$i]=$(expr "$end" - "$beg" )
i=$(expr "$i" + 1 )
done
}

run

echo

i=1

secsum=0

for k in ${secarr[@]}
do
echo $i $k
i=$(expr "$i" + 1)
secsum=$(expr "$secsum" + "$k")
done

echo

echo 'avg:' $(expr "$secsum" / "$times")

rm cmd.$$
