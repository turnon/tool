#!/usr/bin/env ruby

log = `git log --oneline | cat -n`

if ARGV.empty?
  puts log
  exit
end

line_no = ARGV.shift

before = after = nil

log.each_line do |l|
  no, id = l.split
  if after
    before = id
    break
  end
  after = id if no == line_no
end

cmd = "git diff #{before} #{after} --color"

system cmd

puts cmd
