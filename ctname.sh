#!/bin/sh

cd $1

file_create_time(){
while read time1 time2 time3 time4 time5 orgname
do
echo $(date --date="$time1 $time2 $time3 $time4 $time5" +%y%m%d%H%M%S ) $orgname
done<<EOF
$(ls -cl --full-time $1 | grep '^-' | awk '{$1=" ";$2=" ";$3=" ";$4=" ";$5=" ";print $0}')
EOF
}

while read newtime orgname
do
mv -v "$orgname" "$newtime"_"$orgname"
done<<EOF
$(file_create_time . )
EOF
