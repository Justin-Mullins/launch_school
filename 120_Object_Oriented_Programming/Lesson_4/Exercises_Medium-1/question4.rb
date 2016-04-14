# question4.rb

# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single method
# called greet that takes a string argument and prints
# that argument to the terminal.

# Now create two other classes that are derived from Greeting:
# one called Hello and one called Goodbye. 
# The Hello class should have a hi method that takes
# no arguments and prints "Hello". The Goodbye class
# should have a bye method to say "Goodbye". 
# Make use of the Greeting class greet method when 
# implementing the Hello and Goodbye classes - do not use
# any puts in the Hello or Goodbye classes.

# ------ANSWER-------
class Greeting
  def greet(greeting)
    puts greeting
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

stuff = Hello.new
stuff.hi
stuff.greet("great to meet you.")