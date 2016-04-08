# question1.rb

# Question 1

# If we have this code:

class Greeting
  def greet(message)
    puts message
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

# What happens in each of the following cases:


#ANSWER:

case 1:

# a new Hello object is created named hello
hello = Hello.new
# the hi method is called from Hello, which displays "Hello"
hello.hi  
case 2:

# a new Hello object is created named hello
hello = Hello.new
# The Hello class doesn't have access to the bye method,
# so this results in an error. 
hello.bye
case 3:

# a new Hello object is created named hello
hello = Hello.new
# The greet method is called from Hello's superclass,
# but there are no arguments, and it is supposed to have one argument,
# so this results in an error.
hello.greet
case 4:

# a new Hello  object is created named hello
hello = Hello.new
# The greet method from Hello's superclass is called,
# and it has the correct amount of arguments so this displays
# "Goodbye"
hello.greet("Goodbye")
case 5:

# The method hi cannot be called this way
# because it is not a class method.
# to access the hi method, first a new Hello object must be created
# and then the hi method must be called from the new object,
# not from the Hello class itself.
Hello.hi