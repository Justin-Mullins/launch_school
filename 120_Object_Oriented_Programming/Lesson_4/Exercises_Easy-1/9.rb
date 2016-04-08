# 9.rb
#
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

# In the name of the cats_count method we have used self. 
# What does self refer to in this context?

# ANSWER
# The self.cats_count can be accessed by the Cat class itself, 
# by using Cat.cats_count. 

# If it was just cats_count without the self, it would have to 
# accessed from an instance of the Cat class such as cat1.cats_count
# below.

# TEST

puts Cat.cats_count 
cat1 = Cat.new("tabby")
puts Cat.cats_count
cat2 = Cat.new("persian")
puts Cat.cats_count

