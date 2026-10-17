#!/usr/bin/env ruby

require "digest"

USAGE = "Usage: #{File.basename($PROGRAM_NAME)} dir [--action]"

args = ARGV.dup
action = !args.delete("--action").nil?
dir = args.shift

if args.any? || dir.nil? || dir == "-h" || dir == "--help"
  warn USAGE
  exit(dir == "-h" || dir == "--help" ? 0 : 1)
end

unless File.directory?(dir)
  warn "chkdup: not a directory: #{dir}"
  exit 1
end

def mtime(path)
  Time.at(File.mtime(path)).strftime("%F %T")
rescue SystemCallError
  "unknown time"
end

groups = Hash.new { |hash, md5| hash[md5] = [] }
total_files = 0

Dir.glob(File.join(dir, "**", "*"), File::FNM_DOTMATCH).each do |path|
  next unless File.file?(path)

  total_files += 1

  begin
    groups[Digest::MD5.file(path).hexdigest] << path
  rescue SystemCallError => e
    warn "chkdup: cannot read #{path}: #{e.message}"
  end
end

duplicates = groups
  .lazy.select { |_md5, files| files.size > 1 }
  .map { |md5, files| [md5, files.sort_by { |path| [File.mtime(path), path] }] }

if action
  removed = 0
  freed = 0

  duplicates.each do |md5, files|
    files.shift
    files.each do |path|
      begin
        size = File.size(path)
        File.delete(path)
        removed += 1
        freed += size
      rescue SystemCallError => e
        warn "chkdup: cannot remove #{path}: #{e.message}"
      end
    end
  end

  puts "removed #{removed} duplicate file(s), freed #{freed} byte(s)"
  exit 0
end

dup_md5_count = 0
removable_count = 0
duplicates.each do |md5, files|
  puts "#{md5}:"
  files.each { |path| puts "#{mtime(path)} #{path}" }
  dup_md5_count += 1
  removable_count += (files.count - 1)
  puts
end

puts "total #{total_files} file(s), #{dup_md5_count} duplicate md5, #{removable_count} can be removed."
