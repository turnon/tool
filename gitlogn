#!/usr/bin/env ruby

log = `git log --oneline --graph | cat -n`

if ARGV.empty?
  puts log
  exit
end

line_no = ARGV.shift

before = after = nil

log.each_line do |l|
  l_arr = l.split
  no = l_arr[0]
  star = l_arr.index('*')
  next unless star
  id = l_arr[star.succ]
  if after
    before = id
    break
  end
  after = id if no == line_no
end

cmd = "git diff #{before} #{after} --color"

system cmd if before

puts cmd
