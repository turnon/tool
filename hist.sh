#!/bin/sh

cat ~/.bash_history >> hist.txt

sort  hist.txt | uniq -c > hist.$$

mv hist.$$ hist.txt
