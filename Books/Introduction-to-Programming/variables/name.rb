# This program prompts user for their name, the outputs name to string.

puts "What is your first name?"
first_name = gets.chomp
puts "What is your last name?"
last_name = gets.chomp
full_name = first_name + " " + last_name
puts "Hello, #{full_name}, welcome to ruby programming!"
10.times {puts "#{full_name}"}