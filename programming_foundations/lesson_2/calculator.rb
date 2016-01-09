# calculator.rb
# command line calculator

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when 'add'
    'Adding'
  when 'subtract'
    'Subtracting'
  when 'divide'
    'Dividing'
  when 'multiply'
    'Multiplying'
  end
end

num1 = ''
num2 = ''
name = ''
operator = ''

prompt("Command Line Calculator")
prompt("Enter your name:")

loop do
  name = gets.chomp

  if name.empty?()
    prompt("Not a valid name.")
  else
    break
  end
end

prompt("Hi, #{name}!")

loop do # main loop
  loop do
    prompt("Enter first number: ")
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt("That's not a valid number...")
    end
  end

  loop do
    prompt("Enter second number: ")
    num2 = gets.chomp

    if valid_number?(num2)
      break
    else
      prompt("That's not a valid number...")
    end
  end

  prompt("'add', 'subtract', 'divide', 'multiply'")
  prompt("Which operation would you like to perform?")

  loop do
    operator = gets.chomp.downcase()

    if %w(add subtract divide multiply).include?(operator)
      break
    else
      prompt("Must choose add, subtract, divide, or multiply")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when 'add'
             num1.to_i + num2.to_i
           when 'subtract'
             num1.to_i - num2.to_i
           when 'divide'
             num1.to_f / num2.to_f
           when 'multiply'
             num1.to_i * num2.to_i
           end

  prompt("The total is: #{result}")

  prompt("Do you want to perform another calculation?(Y to calculate again)")
  answer = gets.chomp
  break unless answer.downcase().start_with?('y')
end

prompt("Goodbye")
