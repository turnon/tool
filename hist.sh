#!/bin/sh

history -w

cat ~/.bash_history >> hist.txt

sed -e 's/\r//g' hist.txt | sort -u > hist.$$

mv hist.$$ hist.txt
