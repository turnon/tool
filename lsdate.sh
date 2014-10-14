#!/bin/sh

outformat="$1"

while read tim
do
[ -z "$outformat" ] && date -d"$tim" || date -d"$tim" "$outformat"
done
