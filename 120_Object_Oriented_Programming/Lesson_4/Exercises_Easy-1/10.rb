# 10.rb

# If we have the class below, what would you need
# to call to create a new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# ANSWER:

bag1 = Bag.new("brown", "suede")
puts bag1.inspect