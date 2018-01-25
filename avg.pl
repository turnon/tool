perl -lne '$sum += $_; $count += 1; END { print $sum / $count; }' $@
