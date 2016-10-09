#!/bin/env ruby

require 'rack'
require 'socket'

rack_proc = lambda do |env|
	path = File.join('.', env['REQUEST_PATH'])
	if File.exists? path
	  last_mod = File.mtime(path).strftime '%a, %d %b %Y %T GMT'
	  if File.directory? path
	    [200, {'Content-Type' => 'text/plain'}, [`ls -al #{path}`] ]
	  elsif File.extname(path) == '.html'
	    [200, {'Content-Type' => 'text/html'}, File.open(path, File::RDONLY)]
	  elsif File.extname(path) == '.css'
	    [200, {'Content-Type' => 'text/css'}, File.open(path, File::RDONLY)]
	  else
	    [200, {'Content-Type' => 'text/plain', 'Last-Modified' => last_mod}, [File.read(path)]]
	  end
	else
	  [404, {'Content-Type' => 'text/plain'}, ["#{path} does not exist"] ]
	end
end

public_ip = Socket.ip_address_list.select{ |ad| ad.ipv4? && ad.getnameinfo[0] != 'localhost' }[0].ip_address

Rack::Handler::WEBrick.run rack_proc, :Port => 9292, :Host => public_ip
