# calculator.rb
# command line calculator

puts "-----------------------"
puts "Command Line Calculator"
puts "-----------------------"
puts
puts "Enter first number: "
num1 = gets.chomp.to_i
puts "Enter second number: "
num2 = gets.chomp.to_i
puts "'add', 'subtract', 'divide', 'multiply'"
puts "Enter operation: "
operand = gets.chomp

if operand == "add"
  result = num1 + num2   
elsif operand == "subtract"
  result =  num1 - num2
elsif operand == "multiply"
  result =  num1 * num2
elsif operand == "divide"
  result =  num1 / num2
end

puts "The total is: #{result}"
