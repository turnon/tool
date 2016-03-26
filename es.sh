#!/bin/sh

# windows path to unix path
w2u(){
  sed 's/\\/\//g' | sed 's/^\([A-Z]\):/\/\1/'
}

# unix path to windows path
u2w(){
  sed 's/^\///' | sed 's/^\([a-z]\)/\1:/' | sed 's/\//\\/g'
}

# query in current dir tree ?
if [ $1 == "--pwd" ]
then
  path=$(pwd | u2w)
  shift
  q="$path $*"
else
  q="$*"
fi

# execute query
es $q | w2u