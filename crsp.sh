#!/bin/sh

sed -e 's/\r//g' $1 | sed -e 's/[ ]$//'
