#!/bin/sh

history -w

cat ~/.bash_history >> hist.txt

sort -u hist.txt > hist.$$

mv hist.$$ hist.txt
