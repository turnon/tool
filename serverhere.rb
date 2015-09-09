#!/bin/env ruby

require 'rack'
require 'socket'

rack_proc = lambda do |env|
	path = File.join('.', env['REQUEST_PATH'])
	if File.exists? path
	  [200, {'Content-Type' => 'text/html'}, File.open(path, File::RDONLY)] 
	else
	  [404, {'Content-Type' => 'text/plain'}, ["#{path} does not exist"] ]
	end
end

public_ip = Socket.ip_address_list.select{ |ad| ad.ipv4? && ad.getnameinfo[0] != 'localhost' }[0].ip_address

Rack::Handler::WEBrick.run rack_proc, :Port => 9292, :Host => public_ip
