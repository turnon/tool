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

class EnvInspector

  def initialize app
    @app = app
  end

  def call env
    puts env.sort.map{|k,v| "#{green(k)} => #{v}"}.join("\n")
    @app.call env
  end

  def green str
    "\e[32m#{str}\e[0m"
  end
end

class App

  def call env
    req = Rack::Request.new env
    path = File.join('.', req.path_info)

    if not File.exists? path
      return [404, {'Content-Type' => 'text/plain'}, ["#{path} does not exist"] ]
    end

    if File.directory? path
      return [200, {'Content-Type' => 'text/plain'}, [`ls -al #{path}`] ]
    end

    file = FileWrapper.new path

    if_mod_since = req.get_header 'HTTP_IF_MODIFIED_SINCE'
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

app = Rack::Builder.new {
  use Rack::ContentLength
  use EnvInspector
  run App.new
}

Rack::Handler::WEBrick.run app, :Port => 9292, :Host => public_ip
