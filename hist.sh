#!/bin/sh

history -w

cat ~/.bash_history >> hist.txt

sed -e 's/\r//g' hist.txt > hist.$$

sort -u hist.$$ > hist.txt

rm hist.$$
