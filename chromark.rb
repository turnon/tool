#!/usr/bin/env ruby

class Bookmark

  class Category
    attr_reader :added, :moded, :name

    def initialize(line)
      m = line.match(/.*ADD_DATE="(.*)" LAST_MODIFIED="(.*)">(.*)<\/H3>/)
      @added = m[1]
      @moded = m[2]
      @name = m[3]
      @entries = []
    end

    def <<(entry)
      @entries << entry
    end
  end

  class Entry
    attr_reader :href, :added, :name, :path

    def initialize(line, path)
      m = line.match(/<.*HREF="(.*)" ADD_DATE="(.*)".*>(.*)<\/A>/)
      @href = m[1]
      @added = m[2]
      @name = m[3]
      @path = path.dup
      path.last << self
    end

    def path_str
      @path_str ||= @path.size == 1 ? '/' : ('/' + @path[1..-1].map(&:name).join('/'))
    end
  end

  def initialize(argf)
    @entries = []
    @cates = []
    @root = nil

    argf.each do |line|
      case line
      when /\s*<DT><A/
        e = Entry.new(line, @cates)
        @entries << e
      when /\s*<DT><H3/
        c = Category.new(line)
        @root ||= c
        @cates << c
      when /\s*<\/DL><p>/
        @cates.pop
      else
      end
    end
  end

  def dup_names
    return @dup_names if @dup_names

    @dup_names = {}
    @entries.group_by(&:name).each do |name, es|
      next if es.size == 1
      @dup_names[name] = es.map(&:path_str)
    end
    @dup_names
  end
end

bm = Bookmark.new(ARGF)

pp bm.dup_names
