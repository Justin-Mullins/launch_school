# 5.rb
# Which of these two classes has an instance variable
# and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# ANSWER:
# The Pizza class has an instance variable @name. You can
# tell because it has an @ sign infront.