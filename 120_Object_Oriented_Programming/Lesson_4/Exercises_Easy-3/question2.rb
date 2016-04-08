# question2.rb

# Question 2

# In the last question we had the following classes:

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# If we call Hello.hi we get an error message.
# How would you fix this?

#ANSWER:

class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def self.bye
    greet("Goodbye")
  end
end

#TEST

Hello.hi