#!/bin/sh

usage() {
cat<<EOF
Usage: jaru.sh JAR [DIR]
update JAR with classes in DIR (or pwd if DIR not specified).
EOF
}

[ -z $1 ] && usage && exit

jar_to_update=$(readlink -f "$1")

[ -z $2 ] || cd "$2"

jar uvf "$jar_to_update" ./
