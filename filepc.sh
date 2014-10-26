#!/bin/sh

toscan=$([ -z "$1" ] && echo "." || echo "${1%%/}")

p=${toscan%/}
p=${p##*/}

ls -p "$toscan" \
| while read f
do
echo "$p"'/'"$f"
[ -d "$toscan"/"$f" ] && $0 "$toscan"'/'"$f"
done
