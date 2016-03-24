#!/bin/sh

es $@ | sed 's/\\/\//g' | sed 's/^\([A-Z]\):/\/\1/'