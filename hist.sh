#!/bin/sh

history -w

cat ~/.bash_history >> hist.txt

crsp.sh hist.txt | sort -u > hist.$$

mv hist.$$ hist.txt
