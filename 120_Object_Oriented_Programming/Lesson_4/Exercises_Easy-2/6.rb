# 6.rb

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any)
# and how do you know? How would you call a class method?

#ANSWER:
# The self.manufacturer method is a class method.
# you can tell because it has self. prepending the method name.
# The way to call the method is with the class name itself:
Television.manufacturer