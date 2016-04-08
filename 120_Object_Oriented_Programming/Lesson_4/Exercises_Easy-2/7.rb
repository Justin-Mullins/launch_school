# 7.rb

# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works.
# What code would you need to write to test your theory?

#ANSWER:
# THe @@cats_count variable is a class variable that will share
# it's value with all instances of the Cat class. 
# The @@cats_count variable will store the number of cat objects
# created. Everytime a new cat object is created,
# the @@cats_count's value is incremented by 1.

#TEST:
puts Cat.cats_count
cat1 = Cat.new("persian")
puts Cat.cats_count
cat2 = Cat.new("meouth")
puts Cat.cats_count