#!/bin/sh

file_create_time(){
while read time1 time2 time3 orgname
do
echo $(date --date="$time1 $time2 $time3" +%y%m%d%H%M%S ) $orgname
done<<EOF
$(ls -cl $1 | awk '{print $6" "$7" "$8" "$9}')
EOF
}

while read newtime orgname
do
echo $orgname $newtime
done<<EOF
$(file_create_time $1)
EOF