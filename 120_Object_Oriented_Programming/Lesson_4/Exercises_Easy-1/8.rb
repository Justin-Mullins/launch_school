# 8.rb
# 
# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# You can see in the make_one_year_older method
# we have used self. What does self refer to here?


# ANSWER:
# Self refers to the instance of the class that is calling the
# method. That way each instance of the class has a different 
# self.age they are changing.

# TEST:
cat1 = Cat.new("tabby")
cat2 = Cat.new("hairless")

cat1.make_one_year_older
cat1.make_one_year_older
cat2.make_one_year_older
puts cat1.age
puts cat2.age