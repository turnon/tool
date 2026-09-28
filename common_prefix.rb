#!/usr/bin/env ruby

prefix = ARGF.gets
exit unless prefix

prefix = prefix.chomp

while (line = ARGF.gets)
  line = line.chomp
  len = [prefix.length, line.length].min
  i = 0
  i += 1 while i < len && prefix[i] == line[i]
  prefix = prefix[0...i]
  break if prefix.empty?
end

puts "\e[7m#{prefix}\e[0m" unless prefix.empty?