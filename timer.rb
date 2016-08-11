def timer
  a = Time.now
  yield
  b = Time.now
  puts "in #{b - a} seconds"
end