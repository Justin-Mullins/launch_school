# calculator.rb
# command line calculator

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
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

prompt(MESSAGES["title"])
prompt(MESSAGES["name"])

loop do
  name = gets.chomp

  if name.empty?()
    prompt(MESSAGES["invalid_name"])
  else
    break
  end
end

prompt("Hi, #{name}.")

loop do # main loop
  loop do
    prompt(MESSAGES["first_number"])
    num1 = gets.chomp

    if number?(num1)
      break
    else
      prompt(MESSAGES["invalid_number"])
    end
  end

  loop do
    prompt(MESSAGES["second_number"])
    num2 = gets.chomp

    if number?(num2)
      break
    else
      prompt(MESSAGES["invalid_number"])
    end
  end

  prompt(MESSAGES["operator"])
  prompt(MESSAGES["which_operator"])

  loop do
    operator = gets.chomp.downcase()

    if %w(add subtract divide multiply).include?(operator)
      break
    else
      prompt(MESSAGES["operator"])
    end
  end

  prompt("#{operation_to_message(operator)}" + MESSAGES["calculating"])

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

  prompt(MESSAGES["total"] + "#{result}")

  prompt(MESSAGES["another"])
  answer = gets.chomp
  break unless answer.downcase().start_with?('y')
end

prompt("Goodbye")
