#!/bin/perl

while(<>){
chomp;
$line[$n++]=$_;
}

@line=reverse @line;

$format="%s\n" x @line;

printf $format,@line;
