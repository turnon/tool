#!/bin/env ruby

act = ARGV.delete "--do"

action = if act
           ->(o, n){File.rename(o, n)}
         else
           ->(o, n){puts "#{o} -> #{n}" if o != n}
         end
  
pattern = Regexp.new ARGV.shift

replacem = (ARGV.shift || '')

Dir.glob('*').each do |f|
  new_name = f.gsub(pattern, replacem)
  action[f, new_name]
end
