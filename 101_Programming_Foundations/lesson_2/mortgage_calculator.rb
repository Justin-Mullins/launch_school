# mortgage_calculator
# mortgage formula from www.mtgprofessor.com/formulas.htm
require 'pry'

def mortgage(amount, apr, duration)
  total_months = duration * 12
  mpr = apr / 12
  # Mortgage Formula
  monthly_payment = amount * (mpr * (1 + mpr)**total_months) / ((1 + mpr)**total_months - 1)
end

def prompt(message)
  puts "=> #{message}"
end

prompt("Mortgage Calculator")

# Get amount from user
amount = ''
loop do
  prompt("Enter loan amount:")
  amount = gets.chomp.to_i
  if amount > 0
    break
  else
    prompt("Not a valid amount.")
  end
end

# Get APR from user
apr = ''
loop do
  prompt("Enter APR:")
  apr = gets.chomp.to_f
  if apr > 0 && apr < 1
    break
  else
    prompt("Enter APR in decimal format.")
  end
end

# Get loan duration
duration = ''
loop do
  prompt("Enter loan duration in years:")
  duration = gets.chomp.to_f
  if duration > 0
    break
  else
    prompt("Not a valid input.")
  end
end

prompt("Monthly payments of: #{mortgage(amount, apr, duration)}")