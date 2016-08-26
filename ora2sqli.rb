#!/bin/env ruby

Log = -> msg {STDERR.puts msg}

module OraSqli
  module Convertors
    Prompt = [/^prompt.*\n/, '']
    SET = [/^set.*\n/, '']
    ToDateTime = [/to_date\('(\d\d)-(\d\d)-(\d{4}) (\d\d):(\d\d):(\d\d)', 'dd-mm-yyyy hh24:mi:ss'\)/, '"\3-\2-\1 \4:\5:\6"']
    ToDate = [/to_date\('(\d\d)-(\d\d)-(\d{4})', 'dd-mm-yyyy'\)/, '"\3-\2-\1 00:00:00"']
    BlankLine = [/^\n$/, '']
  end
  
  class Convertor
    attr_reader :pattern, :replacement
    def initialize pattern, replacement
      @pattern, @replacement = pattern, replacement
    end
  end
  
  class << self
    def convert file
      convertors.each do |c|
        file.gsub! c.pattern, c.replacement
      end
      puts file
    end
    
    def convertors
      Convertors.constants.map do |c|
        Log.call c
        cv = Convertors.const_get(c)
        Convertor.new cv[0], cv[1]
      end
    end
  end
end

file = File.read ARGV.shift, encoding: 'utf-8'

Log.call "#{file.size / 1024 / 1024} MB"

OraSqli.convert file