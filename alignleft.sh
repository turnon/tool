#!/bin/sh

aleft()
{
sed 's/^[ ]*//'
}

[ -f "$1" ] && aleft "$1" || aleft
