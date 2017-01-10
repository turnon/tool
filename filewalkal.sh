#!/bin/sh

toscan=$( { [ -z "$1" ] && echo "." || echo "$1" ; } | sed 's/\/$//')

ls -ldh --time-style='+%Y/%m/%d' "$toscan"/.* "$toscan"/* | while read permission link owner node size ymd path
do
  [ -e "$path" ] && [ ! "$path" -ef "$toscan" ] && [ ! "$path" -ef "$toscan"'/..' ] || continue
  echo $permission $link $owner $node $size $ymd $path
  [ -d "$path" ] && $0 "$path" 'not root'
done
