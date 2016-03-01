# merge.rb

even = { a: 2, d: 4, f: 6, h: 8, j: 10 }
odd = { a: 1, c: 3, f: 5, g: 7, j: 9 }

puts "========="
puts "hash 1 = "
puts "========="
p even
puts ""
puts "========="
puts "hash 2 = "
puts "========="
p odd
puts ""
puts ""
puts "=========="
puts "  Merge"
puts "=========="
p even.merge(odd)
puts ""
puts "========="
puts "hash 1 = "
puts "========="
p even
puts ""
puts "*********"
puts "hash 2 = "
puts "*********"
p odd
puts ""
puts ""
puts "=========="
puts "  Merge!"
puts "=========="
p even.merge!(odd)
puts ""
puts "*********"
puts "hash 1 = "
puts "*********"
p even
puts ""
puts "*********"
puts "hash 2 = "
puts "*********"
p odd
puts ""

