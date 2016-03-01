#conditional_2.rb

puts "Enter number between 0 and 100:"
number = gets.chomp.to_i

if 0 <= number && number <= 50
  puts "number is between 0 and 50"
elsif 51 <= number && number <= 100
  puts "number is between 50 and 100"
elsif 100 < number
  puts "number is greater than 100"
end
