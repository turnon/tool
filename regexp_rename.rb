#!/usr/bin/env ruby

def usage(msg = nil)
  warn "error: #{msg}" if msg
  warn <<~USAGE
    Usage: #{File.basename($0)} [--do] <regexp> [replacement]

    Rename files/dirs whose basename matches <regexp>.
    Without --do it only prints the planned renames (dry run).

    Examples:
      #{File.basename($0)} '\\.jpeg$' .jpg
      #{File.basename($0)} --do '^IMG_(\\d+)' 'img-\\1'
  USAGE
  exit 1
end

act = ARGV.delete "--do"

usage 'missing <regexp> argument' if ARGV.empty?
usage 'too many arguments' if ARGV.size > 2

pattern_str = ARGV.shift

begin
  pattern_raw = Regexp.new pattern_str
rescue RegexpError => e
  usage "invalid regexp #{pattern_str.inspect}: #{e.message}"
end
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
