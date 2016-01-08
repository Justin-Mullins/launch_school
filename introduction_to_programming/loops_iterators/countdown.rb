# countdown.rb

x = gets.chomp.to_i

until x < 0
  puts x
  x = x - 1
end

puts "Done!"
