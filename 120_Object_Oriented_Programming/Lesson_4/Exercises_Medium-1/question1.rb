# question1.rb

# Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Alyssa glanced over the code quickly and said 
# - "It looks fine, except that you forgot to put
# the @ before balance when you refer to the 
# balance instance variable in the body of the positive_balance?
# method."

# Not so fast", Ben replied. "What I'm doing here is valid
# - I'm not missing an @!"

# Who is right, Ben or Alyssa, and why?

#ANSWER:
# Ben is correct, you don't have to put the @ sign before the
# an instance variable, within a class, while using the attr_reader.
# You only have to put the @ sign when it's initialized in that case. 
# The attr_reader automatically makes a get method for the 
# instance variable, and calling it without the @ sign is calling the
# get method for the instance variable. 