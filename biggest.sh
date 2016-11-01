#!/bin/sh

filewalkwp.sh \
| while read f;do [ -f "$f" ] && du "$f";done \
| sort -nr \
| head -n 10 \
| while read size path;do du -h "$path";done