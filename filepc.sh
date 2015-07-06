#!/bin/sh

toscan=$1

[ -z "$toscan" ] && toscan=$(pwd)

toscan=${toscan%%/}

p=${toscan%/}
p=${p##*/}

ls -Ap "$toscan" \
| while read f
do
echo "$p"'/'"$f"
[ -d "$toscan"/"$f" ] && $0 "$toscan"'/'"$f"
done
