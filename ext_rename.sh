#!/bin/sh

org=$1

new=$2

for f in *."$org";do mv "$f" "${f%.*}"."$new";done
