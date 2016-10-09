#!/bin/env ruby

require 'rack'
require 'socket'

class FileWrapper
  def initialize file
    @f = file
  end

  def last_mod
    @last_mod ||= File.mtime(@f).strftime '%a, %d %b %Y %T GMT'
  end

  def ext
    File.extname(@f).gsub(/\./, '')
  end

  def content_type
    'text/' + (%w{html css}.include?(ext) ? ext : 'plain')
  end

  def to_body
    [File.read(@f)]
  end
end

class App
  def call env
    path = File.join('.', env['REQUEST_PATH'])
    if_mod_since = env['HTTP_IF_MODIFIED_SINCE']

    puts

    if not File.exists? path
      return [404, {'Content-Type' => 'text/plain'}, ["#{file} does not exist"] ]
    end

    if File.directory? path
      return [200, {'Content-Type' => 'text/plain'}, [`ls -al #{path}`] ]
    end

    file = FileWrapper.new path

    if if_mod_since and file.last_mod == if_mod_since
      return [304, {}, []]
    end

    header = {
      'Content-Type' => file.content_type,
      'Last-Modified' => file.last_mod
    }

    [200, header, file.to_body]
  end
end

public_ip = Socket.ip_address_list.select{ |ad| ad.ipv4? && ad.getnameinfo[0] != 'localhost' }[0].ip_address

Rack::Handler::WEBrick.run App.new, :Port => 9292, :Host => public_ip
