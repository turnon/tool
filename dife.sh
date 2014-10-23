#!/bin/sh

# show diff with non-compressed bookmark

main()
{
all=$(ls)
pre=$(echo $all | cut -d' ' -f1)
oth=$(echo $all | cut -d' ' -f2- )

for nex in $oth
do
diff $pre $nex | grep 'HREF' >difdetail.$$
rsub=$(grep -c '^<' difdetail.$$ )
radd=$(grep -c '^>' difdetail.$$ )
echo $nex $rsub $radd
pre=$nex
done
}

cd $1 && main && rm -f difdetail.$$
