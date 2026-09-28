#!/usr/bin/env ruby

act = ARGV.delete "--do"

pattern_str = ARGV.shift
pattern_raw = Regexp.new pattern_str
pattern_wrap = Regexp.new "(#{pattern_str})"

replacem = (ARGV.shift || '')

Dir.glob('**/*').each do |f|
  dir, base = File.dirname(f), File.basename(f)

  unless base =~ pattern_raw
    next
  end

  if act
    new_base = base.gsub(pattern_raw, replacem)
    File.rename(f, File.join(dir, new_base))
    next
  end

  highlight_old = base.gsub(pattern_wrap, "\e[1;91m" + '\1' + "\e[0m")
  highlight_new = base.gsub(pattern_raw, "\e[1;92m#{replacem}\e[0m")
  puts "#{File.join(dir, highlight_old)} \e[1;33m->\e[0m #{File.join(dir, highlight_new)}"
end
