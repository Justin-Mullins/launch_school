# exercise_3.rb

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
odd_numbers = numbers.select! do |number|
   number % 2 == 1
end

puts ""
puts "Odd numbers:"
odd_numbers.each do |number|
  p number
end
