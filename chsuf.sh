#!/bin/sh

org=${1}

new=${2}

dir=${3:-.}

cd ${dir}

for f in $(ls *.${org})
do
mv "${f}" "${f%%.${org}}.${new}"
done
