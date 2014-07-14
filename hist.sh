#!/bin/sh

history -w

cat ~/.bash_history >> hist.txt

sh crsp.sh hist.txt | sort -u > hist.$$

mv hist.$$ hist.txt
