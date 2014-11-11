#!/bin/sh

toscan=$([ -z "$1" ] && echo "." || echo "$1")

for f in "$toscan"/*
do
[ -e "$f" ] || continue
printf '%-s\n' "$f"
[ -d "$f" ] && $0 "$f"
done
