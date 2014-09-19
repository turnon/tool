#!/bin/sh

awk '{ \
a=""; \
for(i=length();i>0;i--) a=a""substr($0,i,1); \
print a \
}'
