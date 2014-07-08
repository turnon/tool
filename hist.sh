#!/bin/sh

history -w

cat ~/.bash_history >> hist.txt

sed -e 's/\r//g' hist.txt | sed -e 's/[ ]$//' | sort -u > hist.$$

mv hist.$$ hist.txt
