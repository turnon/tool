#!/bin/sh

dest="$1"

[ -z "$dest" ] && echo "missing destination" 1>&2 && exit

while read f
do
  parent=$(dirname "$f")
  new_dest="$dest/$parent"
  new_file=$(basename "$f")
  mkdir -p "$new_dest"
  cp "$f" "$new_dest/$new_file"
done
