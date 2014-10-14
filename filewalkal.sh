#!/bin/sh

toscan=$( { [ -z "$1" ] && echo "." || echo "$1" ; } | sed 's/\/$//')

[ -z "$2" ] && ls -ld "$toscan"

for f in "$toscan"/*
do
[ -e "$f" ] || continue
[ -d "$f" ] && { ls -ld "$f"  ; $0 "$f" 'not root'; } || ls -l "$f"
done
